package fixtures

import (
	"context"
	"math/rand"
	"skeleton/ent"
	"time"

	"github.com/Pallinder/go-randomdata"
)

const transactionCount = 500

func (r refs) transaction() *ent.Transaction {
	m := r[transactionKey].([]*ent.Transaction)
	return m[rand.Intn(len(m))]
}

func transactions(refs refs, c *ent.Client) error {
	b := make([]*ent.TransactionCreate, transactionCount)
	for i := 0; i < transactionCount; i++ {
		t, err := time.Parse(randomdata.DateOutputLayout, randomdata.FullDate())
		if err != nil {
			return err
		}

		b[i] = c.Transaction.Create().
			SetDate(t).
			SetAmount(randomdata.Number(-100*10, -1)).
			SetAccount(refs.account()).
			SetUser(refs.user())
	}

	var err error
	refs[transactionKey], err = c.Transaction.CreateBulk(b...).Save(context.Background())

	return err
}
