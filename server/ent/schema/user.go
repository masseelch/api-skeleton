package schema

import (
	"regexp"

	"github.com/facebook/ent"
	"github.com/facebook/ent/schema"
	"github.com/facebook/ent/schema/edge"
	"github.com/facebook/ent/schema/field"
	"github.com/masseelch/elk"
)

// User holds the schema definition for the User entity.
type User struct {
	ent.Schema
}

// Fields of the User.
func (User) Fields() []ent.Field {
	return []ent.Field{
		field.Int("id").
			StructTag(`groups:"user:list"`),
		field.String("email").
			Unique().
			Match(regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")).
			StructTag(`groups:"user:list"`),
		field.String("password").
			Sensitive(),
		field.Bool("enabled").
			Default(false).
			StructTag(`groups:"user:list"`),
	}
}

// Edges of the User.
func (User) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("sessions", Session.Type).
			StructTag(`json:"-"`),
		edge.From("accounts", Account.Type).
			Ref("users").
			StructTag(`json:"accounts,omitempty" groups:"user:read"`).
			Annotations(elk.FieldAnnotation{Create: false}),
		edge.To("transactions", Transaction.Type).
			StructTag(`json:"transactions,omitempty" groups:"user:read"`).
			Annotations(elk.FieldAnnotation{Create: false}),
	}
}

// Annotations of the User.
func (User) Annotations() []schema.Annotation {
	return []schema.Annotation{
		edge.Annotation{
			StructTag: `json:"edges" groups:"user:read"`,
		},
	}
}
