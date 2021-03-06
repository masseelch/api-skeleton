// Code generated by entc, DO NOT EDIT.

package ent

import (
	"skeleton/ent/schema"
	"skeleton/ent/user"
)

// The init function reads all schema descriptors with runtime code
// (default values, validators, hooks and policies) and stitches it
// to their package variables.
func init() {
	userFields := schema.User{}.Fields()
	_ = userFields
	// userDescEmail is the schema descriptor for email field.
	userDescEmail := userFields[1].Descriptor()
	// user.EmailValidator is a validator for the "email" field. It is called by the builders before save.
	user.EmailValidator = userDescEmail.Validators[0].(func(string) error)
	// userDescEnabled is the schema descriptor for enabled field.
	userDescEnabled := userFields[3].Descriptor()
	// user.DefaultEnabled holds the default value on creation for the enabled field.
	user.DefaultEnabled = userDescEnabled.Default.(bool)
}
