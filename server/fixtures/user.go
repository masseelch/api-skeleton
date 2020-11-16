package fixtures

import (
	"context"
	"math/rand"
	"skeleton/ent"

	"github.com/Pallinder/go-randomdata"
	"golang.org/x/crypto/bcrypt"
)

const userCount = 2

func (r refs) user() *ent.User {
	m := r[userKey].([]*ent.User)
	return m[rand.Intn(len(m))]
}

func (r refs) defaultUser() *ent.User {
	m := r[userKey].([]*ent.User)
	return m[0]
}

func users(refs refs, c *ent.Client) error {
	p, err := bcrypt.GenerateFromPassword([]byte("passw0rd!"), 0)
	if err != nil {
		return err
	}

	b := make([]*ent.UserCreate, userCount+1)

	b[0] = c.User.Create().
		SetEmail("user@api.com").
		SetFirstName("Example").
		SetLastName("User").
		SetPassword(string(p)).
		SetEnabled(true)

	for i := 1; i <= userCount; i++ {
		b[i] = c.User.Create().
			SetEmail(randomdata.Email()).
			SetFirstName(randomdata.FirstName(randomdata.RandomGender)).
			SetLastName(randomdata.LastName()).
			SetPassword(string(p)).
			SetEnabled(true)
	}

	refs[userKey], err = c.User.CreateBulk(b...).Save(context.Background())

	return err
}
