package schema

import (
	"github.com/facebook/ent"
	"github.com/facebook/ent/schema"
	"github.com/facebook/ent/schema/edge"
	"github.com/facebook/ent/schema/field"
	"github.com/masseelch/elk"
	server "skeleton"
	"skeleton/ent/tag"
)

// Tag holds the schema definition for the Tag entity.
type Tag struct {
	ent.Schema
}

// Fields of the Tag.
func (Tag) Fields() []ent.Field {
	return []ent.Field{
		field.Int("id").
			StructTag(`groups:"tag:list,tag:read"`),
		field.String("title").
			StructTag(`groups:"tag:list,tag:read"`),
		field.Uint32("color").
			GoType(server.Color(0)).
			StructTag(`groups:"tag:list,tag:read"`),
	}
}

// Edges of the Tag.
func (Tag) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("transactions", Transaction.Type).
			Ref("tags").
			StructTag(`json:"transactions,omitempty" groups:"tag:read"`),
	}
}

// Annotations of the Tag.
func (Tag) Annotations() []schema.Annotation {
	return []schema.Annotation{
		elk.HandlerAnnotation{
			DefaultListOrder: []elk.Order{
				{Order: "asc", Field: tag.FieldTitle},
			},
		},
	}
}
