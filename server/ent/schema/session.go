package schema

import (
	"github.com/facebook/ent"
	"github.com/facebook/ent/schema"
	"github.com/facebook/ent/schema/edge"
	"github.com/facebook/ent/schema/field"
	"github.com/masseelch/elk"
	"github.com/masseelch/go-token"
)

// Session holds the schema definition for the Session entity.
type Session struct {
	ent.Schema
}

// Fields of the Session.
func (Session) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").
			GoType(token.Token("")).
			StructTag(`json:"token" groups:"auth:login"`),
		field.Time("idleTimeExpiredAt"),
		field.Time("lifeTimeExpiredAt").
			Immutable().
			StructTag(`groups:"auth:login"`),
	}
}

// Edges of the Session.
func (Session) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("user", User.Type).
			Ref("sessions").
			Unique().
			StructTag(`json:"user" groups:"auth:login"`),
	}
}

// Annotations of the Session.
func (Session) Annotations() []schema.Annotation {
	return []schema.Annotation{
		elk.HandlerAnnotation{
			SkipGeneration: true,
		},
		edge.Annotation{
			StructTag: `json:"edges" groups:"auth:login"`,
		},
	}
}
