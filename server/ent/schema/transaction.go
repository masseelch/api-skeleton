package schema

import (
	"github.com/facebook/ent"
	"github.com/facebook/ent/schema"
	"github.com/facebook/ent/schema/edge"
	"github.com/facebook/ent/schema/field"
	"github.com/masseelch/elk"
	server "skeleton"
)

// Transaction holds the schema definition for the Transaction entity.
type Transaction struct {
	ent.Schema
}

// Fields of the Transaction.
func (Transaction) Fields() []ent.Field {
	return []ent.Field{
		field.Int("id").
			StructTag(`groups:"transaction:list,transaction:read"`),
		field.Time("date").
			StructTag(`groups:"transaction:list,transaction:read"`),
		field.Int("amount").
			GoType(server.Money(0)).
			StructTag(`groups:"transaction:list,transaction:read"`),
		field.String("title").
			StructTag(`groups:"transaction:list,transaction:read"`),
	}
}

// Edges of the Transaction.
func (Transaction) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("user", User.Type).
			Ref("transactions").
			Unique().
			StructTag(`json:"user,omitempty" groups:"transaction:list,transaction:read"`),
		edge.From("account", Account.Type).
			Ref("transactions").
			Unique().
			StructTag(`json:"account,omitempty" groups:"transaction:list,transaction:read"`),
		edge.To("tags", Tag.Type).
			Required().
			StructTag(`json:"tags,omitempty" groups:"transaction:list,transaction:read"`),
	}
}

// Annotations of the Transaction.
func (Transaction) Annotations() []schema.Annotation {
	return []schema.Annotation{
		edge.Annotation{
			StructTag: `json:"edges" groups:"transaction:list,transaction:read"`,
		},
		elk.HandlerAnnotation{
			ListGroups:   []string{"transaction:list", "user:list", "tag:list", "account:list"},
			CreateGroups: []string{"transaction:read", "user:list", "tag:list", "account:list"},
		},
	}
}
