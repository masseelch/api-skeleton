package schema

import (
	"github.com/facebook/ent"
	"github.com/facebook/ent/schema"
	"github.com/facebook/ent/schema/edge"
	"github.com/facebook/ent/schema/field"
	"github.com/masseelch/elk"
	"skeleton/ent/transaction"
)

// Account holds the schema definition for the Account entity.
type Account struct {
	ent.Schema
}

// Fields of the Account.
func (Account) Fields() []ent.Field {
	return []ent.Field{
		field.Int("id").
			StructTag(`groups:"account:list"`),
		field.String("title").
			StructTag(`groups:"account:list"`),
	}
}

// Edges of the Account.
func (Account) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("users", User.Type).
			StructTag(`json:"users,omitempty" groups:"account:list,account:read"`),
		edge.To("transactions", Transaction.Type).
			StructTag(`json:"transactions,omitempty" groups:"account:list,account:read"`).
			Annotations(
				elk.EdgeAnnotation{
					DefaultOrder: []elk.Order{
						{Order: "desc", Field: transaction.FieldDate},
					},
				},
			),
	}
}

// Annotations of the Transaction.
func (Account) Annotations() []schema.Annotation {
	return []schema.Annotation{
		edge.Annotation{
			StructTag: `json:"edges" groups:"account:list"`,
		},
	}
}
