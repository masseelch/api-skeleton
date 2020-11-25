package fixtures

import (
	"context"
	"fmt"
	"github.com/Pallinder/go-randomdata"
	"math/rand"
	server "skeleton"
	"skeleton/ent"
	"strings"
)

const (
	tagCount  = 6
	maxRounds = 10000
)

var colors = []uint32{
	0xfffe4a49,
	0xff2ab7ca,
	0xfffed766,
	0xffe6e6ea,
	0xff03396c,
	0xff7bc043,
}

func (r refs) tag() *ent.Tag {
	m := r[tagKey].([]*ent.Tag)
	return m[rand.Intn(len(m))]
}

func (r refs) tags(c int) []*ent.Tag {
	ts := make([]*ent.Tag, 0)

	i := 0
	for len(ts) < c && i < maxRounds {
		t := r.tag()
		if !hasTag(ts, t) {
			ts = append(ts, t)
		}

		i++
	}

	return ts
}

func tags(refs refs, c *ent.Client) error {
	b := make([]*ent.TagCreate, tagCount)
	for i := 0; i < tagCount; i++ {
		b[i] = c.Tag.Create().
			SetTitle(strings.ToUpper(fmt.Sprintf("%s %s", randomdata.Adjective(), randomdata.Noun()))).
			SetColor(server.Color(colors[i]))
	}

	var err error
	refs[tagKey], err = c.Tag.CreateBulk(b...).Save(context.Background())

	return err
}

func hasTag(ts []*ent.Tag, t *ent.Tag) bool {
	for _, e := range ts {
		if e.ID == t.ID {
			return true
		}
	}

	return false
}