package fixtures

import (
	"context"
	"math/rand"
	"skeleton/ent"

	"github.com/Pallinder/go-randomdata"
)

const accountCount = 5

func (r refs) account() *ent.Account {
	m := r[accountKey].([]*ent.Account)
	return m[rand.Intn(len(m))]
}

func accounts(refs refs, c *ent.Client) error {
	b := make([]*ent.AccountCreate, accountCount)
	for i := 0; i < accountCount; i++ {
		// t, err := time.Parse(randomdata.DateOutputLayout, randomdata.FullDate())
		// if err != nil {
		// 	return err
		// }

		b[i] = c.Account.Create().
			SetTitle(randomdata.SillyName()).
			AddUsers(refs.user())
	}

	var err error
	refs[accountKey], err = c.Account.CreateBulk(b...).Save(context.Background())

	return err
}
