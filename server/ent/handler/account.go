// Code generated by entc, DO NOT EDIT.

package handler

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/go-chi/chi"
	"github.com/go-playground/validator/v10"
	"github.com/liip/sheriff"
	"github.com/masseelch/render"
	"github.com/sirupsen/logrus"

	"skeleton/ent"
	"skeleton/ent/account"
)

// The AccountHandler.
type AccountHandler struct {
	r *chi.Mux

	client    *ent.Client
	validator *validator.Validate
	logger    *logrus.Logger
}

// Create a new AccountHandler
func NewAccountHandler(c *ent.Client, v *validator.Validate, log *logrus.Logger) *AccountHandler {
	return &AccountHandler{
		r:         chi.NewRouter(),
		client:    c,
		validator: v,
		logger:    log,
	}
}

// Implement the net/http Handler interface.
func (h AccountHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	h.r.ServeHTTP(w, r)
}

// Enable all endpoints.
func (h *AccountHandler) EnableAllEndpoints() *AccountHandler {
	h.EnableCreateEndpoint()
	h.EnableReadEndpoint()
	h.EnableUpdateEndpoint()
	h.EnableListEndpoint()
	return h
}

// Enable the create operation.
func (h *AccountHandler) EnableCreateEndpoint() *AccountHandler {
	h.r.Post("/", h.Create)
	return h
}

// Enable the read operation.
func (h *AccountHandler) EnableReadEndpoint() *AccountHandler {
	h.r.Get("/{id:\\d+}", h.Read)
	return h
}

// Enable the update operation.
func (h *AccountHandler) EnableUpdateEndpoint() *AccountHandler {
	h.r.Get("/{id:\\d+}", h.Update)
	return h
}

// Enable the list operation.
func (h *AccountHandler) EnableListEndpoint() *AccountHandler {
	h.r.Get("/", h.List)
	return h
}

// struct to bind the post body to.
type accountCreateRequest struct {
	Title string `json:"title,omitempty" `
	Users []int  `json:"users,omitempty" `
}

// This function creates a new Account model and stores it in the database.
func (h AccountHandler) Create(w http.ResponseWriter, r *http.Request) {
	// Get the post data.
	d := accountCreateRequest{} // todo - allow form-url-encdoded/xml/protobuf data.
	if err := json.NewDecoder(r.Body).Decode(&d); err != nil {
		h.logger.WithError(err).Error("error decoding json")
		render.BadRequest(w, r, "invalid json string")
		return
	}

	// Validate the data.
	if err := h.validator.Struct(d); err != nil {
		if err, ok := err.(*validator.InvalidValidationError); ok {
			h.logger.WithError(err).Error("error validating request data")
			render.InternalServerError(w, r, nil)
			return
		}

		h.logger.WithError(err).Info("validation failed")
		render.BadRequest(w, r, err)
		return
	}

	// Save the data.
	b := h.client.Account.Create().
		SetTitle(d.Title).
		AddUserIDs(d.Users...)

	// Store in database.
	e, err := b.Save(r.Context())
	if err != nil {
		h.logger.WithError(err).Error("error saving Account")
		render.InternalServerError(w, r, nil)
		return
	}

	// Serialize the data.
	j, err := sheriff.Marshal(&sheriff.Options{Groups: []string{"account:read"}}, e)
	if err != nil {
		h.logger.WithError(err).WithField("Account.id", e.ID).Error("serialization error")
		render.InternalServerError(w, r, nil)
		return
	}

	h.logger.WithField("account", e.ID).Info("account rendered")
	render.OK(w, r, j)
}

// This function fetches the Account model identified by a give url-parameter from
// database and returns it to the client.
func (h AccountHandler) Read(w http.ResponseWriter, r *http.Request) {
	idp := chi.URLParam(r, "id")
	if idp == "" {
		h.logger.WithField("id", idp).Info("empty 'id' url param")
		render.BadRequest(w, r, "id cannot be ''")
		return
	}
	id, err := strconv.Atoi(idp)
	if err != nil {
		h.logger.WithField("id", idp).Info("error parsing url parameter 'id'")
		render.BadRequest(w, r, "id must be a positive integer greater zero")
		return
	}

	// todo - nested eager loading?
	e, err := h.client.Account.Query().Where(account.ID(id)).Only(r.Context())
	if err != nil {
		switch err.(type) {
		case *ent.NotFoundError:
			h.logger.WithError(err).WithField("Account.id", id).Debug("job not found")
			render.NotFound(w, r, err)
			return
		case *ent.NotSingularError:
			h.logger.WithError(err).WithField("Account.id", id).Error("duplicate entry for id")
			render.InternalServerError(w, r, nil)
			return
		default:
			h.logger.WithError(err).WithField("Account.id", id).Error("error fetching node from db")
			render.InternalServerError(w, r, nil)
			return
		}
	}

	d, err := sheriff.Marshal(&sheriff.Options{Groups: []string{"account:list"}}, e)
	if err != nil {
		h.logger.WithError(err).WithField("Account.id", id).Error("serialization error")
		render.InternalServerError(w, r, nil)
		return
	}

	h.logger.WithField("account", e.ID).Info("account rendered")
	render.OK(w, r, d)
}

// struct to bind the post body to.
type accountUpdateRequest struct {
	Title string `json:"title,omitempty" `
	Users []int  `json:"users,omitempty" `
}

// This function updates a given Account model and saves the changes in the database.
func (h AccountHandler) Update(w http.ResponseWriter, r *http.Request) {
	// Get the post data.
	d := accountUpdateRequest{} // todo - allow form-url-encdoded/xml/protobuf data.
	if err := json.NewDecoder(r.Body).Decode(&d); err != nil {
		h.logger.WithError(err).Error("error decoding json")
		render.BadRequest(w, r, "invalid json string")
		return
	}

	// Validate the data.
	if err := h.validator.Struct(d); err != nil {
		if err, ok := err.(*validator.InvalidValidationError); ok {
			h.logger.WithError(err).Error("error validating request data")
			render.InternalServerError(w, r, nil)
			return
		}

		h.logger.WithError(err).Info("validation failed")
		render.BadRequest(w, r, err)
		return
	}

	// Save the data.
	b := h.client.Account.Update().
		SetTitle(d.Title).
		AddUserIDs(d.Users...) // todo - remove ids that are not given in the patch-data

	// Save in database.
	e, err := b.Save(r.Context())
	if err != nil {
		h.logger.WithError(err).Error("error saving Account")
		render.InternalServerError(w, r, nil)
		return
	}

	// Serialize the data.
	j, err := sheriff.Marshal(&sheriff.Options{Groups: []string{"account:read"}}, e)
	if err != nil {
		h.logger.WithError(err).WithField("Account.id", e.ID).Error("serialization error")
		render.InternalServerError(w, r, nil)
		return
	}

	h.logger.WithField("account", e.ID).Info("account rendered")
	render.OK(w, r, j)
}

// This function queries for Account models. Can be filtered by query parameters.
func (h AccountHandler) List(w http.ResponseWriter, r *http.Request) {
	q := h.client.Account.Query()

	// Pagination
	var err error
	page = 1
	itemsPerPage = 30

	if d := r.URL.Query().Get("itemsPerPage"); d != "" {
		itemsPerPage, err = strconv.Atoi(d)
		if err != nil {
			l.WithField("itemsPerPage", d).Info("error parsing query parameter 'itemsPerPage'")
			render.BadRequest(w, r, "itemsPerPage must be a positive integer greater zero")
			return
		}
	}

	if d := r.URL.Query().Get("page"); d != "" {
		page, err = strconv.Atoi(d)
		if err != nil {
			l.WithField("page", d).Info("error parsing query parameter 'page'")
			render.BadRequest(w, r, "page must be a positive integer greater zero")
			return
		}
	}

	q = q.Limit(itemsPerPage).Offset((page - 1) * itemsPerPage)

	// Use the query parameters to filter the query. todo - nested filter?
	if f := r.URL.Query().Get("title"); f != "" {
		q = q.Where(account.Title(f))
	}

	es, err := q.All(r.Context())
	if err != nil {
		h.logger.WithError(err).Error("error querying database") // todo - better error
		render.InternalServerError(w, r, nil)
		return
	}

	d, err := sheriff.Marshal(&sheriff.Options{Groups: []string{"account:read"}}, es)
	if err != nil {
		h.logger.WithError(err).Error("serialization error")
		render.InternalServerError(w, r, nil)
		return
	}

	h.logger.WithField("amount", len(es)).Info("jobs rendered")
	render.OK(w, r, d)
}