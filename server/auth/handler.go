package auth

import (
	"net/http"
	"skeleton/ent"
	"skeleton/ent/user"
	"time"

	"github.com/go-playground/validator/v10"
	"github.com/liip/sheriff"
	"github.com/masseelch/go-token"
	"github.com/masseelch/render"
	"github.com/sirupsen/logrus"
	"golang.org/x/crypto/bcrypt"
)

var (
	SessionIdleTime = 15 * time.Minute
	SessionLifeTime = 24 * time.Hour

	errBadCredentials   = "Bad Credentials"
	errMalformedRequest = "Malformed Request"
	errUserBlocked      = "User Blocked"

	logMalformedCredentials = "malformed credentials"
	logPasswordMismatch     = "password mismatch"
	logParseError           = "error parsing credentials"
	logTokenGenerationError = "error generating token"
	logTokenSaveError       = "error saving token"
	logUserBlocked          = "user blocked"
	logUserNotFound         = "user not found"
	logUserLoggedIn         = "user logged in"
)

func LoginHandler(c *ent.Client, v *validator.Validate, log *logrus.Logger) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// Extract the credentials form the request.
		cr, err := credentialsFromRequest(r)
		if err != nil {
			log.WithError(err).Error(logParseError)
			render.BadRequest(w, r, errMalformedRequest)
			return
		}

		// Validate the credentials.
		if err := v.Struct(cr); err != nil {
			log.WithError(err).Info(logMalformedCredentials)
			render.BadRequest(w, r, err)
			return
		}

		// Get the user for the given email.
		u, err := c.User.Query().Where(user.Email(cr.Email)).Only(r.Context())
		if err != nil {
			log.WithError(err).WithField("email", cr.Email).Info(logUserNotFound)
			render.Unauthorized(w, r, errBadCredentials)
			return
		}

		// Check password.
		if err := bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(cr.Password)); err != nil {
			log.WithError(err).Info(logPasswordMismatch)
			render.Unauthorized(w, r, errBadCredentials)
			return
		}

		// Check if user is blocked.
		if !u.Enabled {
			log.WithError(err).Info(logUserBlocked)
			render.Forbidden(w, r, errUserBlocked)
			return
		}

		// Create a new session.
		t, err := token.GenerateToken(64)
		if err != nil {
			log.WithError(err).Error(logTokenGenerationError)
			render.InternalServerError(w, r, nil)
			return
		}

		n := time.Now()
		s, err := c.Session.Create().
			SetID(t).
			SetIdleTimeExpiredAt(n.Add(SessionIdleTime)).
			SetLifeTimeExpiredAt(n.Add(SessionLifeTime)).
			SetUser(u).
			Save(r.Context())
		if err != nil {
			log.WithError(err).Error(logTokenSaveError)
			render.InternalServerError(w, r, nil)
			return
		}

		s.Edges.User = u

		d, err := sheriff.Marshal(&sheriff.Options{Groups: []string{"auth:login"}}, s)
		if err != nil {
			log.WithError(err).Error("serialization error")
			render.InternalServerError(w, r, nil)
			return
		}

		log.WithField("email", cr.Email).Info(logUserLoggedIn)
		render.OK(w, r, d)
	}
}

func CheckHandler(c *ent.Client, log *logrus.Logger) http.HandlerFunc {
	// If the token is still valid the middleware will pass the request on to the callback function,
	// which will return a 204. Otherwise the middleware itself will return a 401.
	return Middleware(c, log)(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		render.NoContent(w, r)
	})).ServeHTTP
}
