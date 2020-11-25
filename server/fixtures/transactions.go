package fixtures

import (
	"context"
	"fmt"
	"math/rand"
	server "skeleton"
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
			SetAmount(server.Money(randomdata.Number(-100*10, -1))).
			SetTitle(fmt.Sprintf("%s %s %s", randomdata.Adjective(), randomdata.Noun(), randomdata.SillyName())).
			SetAccount(refs.account()).
			SetUser(refs.user()).
			AddTags(refs.tags(randomdata.Number(1, 3))...)
	}

	var err error
	refs[transactionKey], err = c.Transaction.CreateBulk(b...).Save(context.Background())

	return err
}
