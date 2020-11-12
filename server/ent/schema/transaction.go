package schema

import (
	"github.com/facebook/ent"
	"github.com/facebook/ent/schema"
	"github.com/facebook/ent/schema/edge"
	"github.com/facebook/ent/schema/field"
)

// Transaction holds the schema definition for the Transaction entity.
type Transaction struct {
	ent.Schema
}

// Fields of the Transaction.
func (Transaction) Fields() []ent.Field {
	return []ent.Field{
		field.Int("id").
			StructTag(`groups:"transaction:list"`),
		field.Time("date").
			StructTag(`groups:"transaction:list"`),
		field.Int("amount").
			StructTag(`groups:"transaction:list"`),
	}
}

// Edges of the Transaction.
func (Transaction) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("user", User.Type).
			Ref("transactions").
			Unique().
			StructTag(`json:"user,omitempty" groups:"transaction:list"`),
		edge.From("account", Account.Type).
			Ref("transactions").
			Unique().
			StructTag(`json:"account,omitempty" groups:"transaction:list"`),
	}
}

// Annotations of the Transaction.
func (Transaction) Annotations() []schema.Annotation {
	return []schema.Annotation{
		edge.Annotation{
			StructTag: `json:"edges" groups:"transaction:list"`,
		},
	}
}
