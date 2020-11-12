package fixtures

import (
	"math/rand"
	"skeleton/ent"
	"time"
)

const (
	userKey = iota
	accountKey
	transactionKey
)

type refs map[uint]interface{}

func Load(c *ent.Client) error {
	rand.Seed(time.Now().Unix())
	refs := make(refs)

	if err := users(refs, c); err != nil {
		return err
	}
	if err := sessions(refs, c); err != nil {
		return err
	}
	if err := accounts(refs, c); err != nil {
		return err
	}
	if err := transactions(refs, c); err != nil {
		return err
	}

	return nil
}
