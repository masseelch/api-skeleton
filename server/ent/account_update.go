// Code generated by entc, DO NOT EDIT.

package ent

import (
	"context"
	"fmt"
	"skeleton/ent/account"
	"skeleton/ent/predicate"
	"skeleton/ent/user"

	"github.com/facebook/ent/dialect/sql"
	"github.com/facebook/ent/dialect/sql/sqlgraph"
	"github.com/facebook/ent/schema/field"
)

// AccountUpdate is the builder for updating Account entities.
type AccountUpdate struct {
	config
	hooks    []Hook
	mutation *AccountMutation
}

// Where adds a new predicate for the builder.
func (au *AccountUpdate) Where(ps ...predicate.Account) *AccountUpdate {
	au.mutation.predicates = append(au.mutation.predicates, ps...)
	return au
}

// SetTitle sets the title field.
func (au *AccountUpdate) SetTitle(s string) *AccountUpdate {
	au.mutation.SetTitle(s)
	return au
}

// AddUserIDs adds the users edge to User by ids.
func (au *AccountUpdate) AddUserIDs(ids ...int) *AccountUpdate {
	au.mutation.AddUserIDs(ids...)
	return au
}

// AddUsers adds the users edges to User.
func (au *AccountUpdate) AddUsers(u ...*User) *AccountUpdate {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return au.AddUserIDs(ids...)
}

// Mutation returns the AccountMutation object of the builder.
func (au *AccountUpdate) Mutation() *AccountMutation {
	return au.mutation
}

// ClearUsers clears all "users" edges to type User.
func (au *AccountUpdate) ClearUsers() *AccountUpdate {
	au.mutation.ClearUsers()
	return au
}

// RemoveUserIDs removes the users edge to User by ids.
func (au *AccountUpdate) RemoveUserIDs(ids ...int) *AccountUpdate {
	au.mutation.RemoveUserIDs(ids...)
	return au
}

// RemoveUsers removes users edges to User.
func (au *AccountUpdate) RemoveUsers(u ...*User) *AccountUpdate {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return au.RemoveUserIDs(ids...)
}

// Save executes the query and returns the number of rows/vertices matched by this operation.
func (au *AccountUpdate) Save(ctx context.Context) (int, error) {
	var (
		err      error
		affected int
	)
	if len(au.hooks) == 0 {
		affected, err = au.sqlSave(ctx)
	} else {
		var mut Mutator = MutateFunc(func(ctx context.Context, m Mutation) (Value, error) {
			mutation, ok := m.(*AccountMutation)
			if !ok {
				return nil, fmt.Errorf("unexpected mutation type %T", m)
			}
			au.mutation = mutation
			affected, err = au.sqlSave(ctx)
			mutation.done = true
			return affected, err
		})
		for i := len(au.hooks) - 1; i >= 0; i-- {
			mut = au.hooks[i](mut)
		}
		if _, err := mut.Mutate(ctx, au.mutation); err != nil {
			return 0, err
		}
	}
	return affected, err
}

// SaveX is like Save, but panics if an error occurs.
func (au *AccountUpdate) SaveX(ctx context.Context) int {
	affected, err := au.Save(ctx)
	if err != nil {
		panic(err)
	}
	return affected
}

// Exec executes the query.
func (au *AccountUpdate) Exec(ctx context.Context) error {
	_, err := au.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (au *AccountUpdate) ExecX(ctx context.Context) {
	if err := au.Exec(ctx); err != nil {
		panic(err)
	}
}

func (au *AccountUpdate) sqlSave(ctx context.Context) (n int, err error) {
	_spec := &sqlgraph.UpdateSpec{
		Node: &sqlgraph.NodeSpec{
			Table:   account.Table,
			Columns: account.Columns,
			ID: &sqlgraph.FieldSpec{
				Type:   field.TypeInt,
				Column: account.FieldID,
			},
		},
	}
	if ps := au.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := au.mutation.Title(); ok {
		_spec.Fields.Set = append(_spec.Fields.Set, &sqlgraph.FieldSpec{
			Type:   field.TypeString,
			Value:  value,
			Column: account.FieldTitle,
		})
	}
	if au.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   account.UsersTable,
			Columns: account.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: &sqlgraph.FieldSpec{
					Type:   field.TypeInt,
					Column: user.FieldID,
				},
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := au.mutation.RemovedUsersIDs(); len(nodes) > 0 && !au.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   account.UsersTable,
			Columns: account.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: &sqlgraph.FieldSpec{
					Type:   field.TypeInt,
					Column: user.FieldID,
				},
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := au.mutation.UsersIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   account.UsersTable,
			Columns: account.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: &sqlgraph.FieldSpec{
					Type:   field.TypeInt,
					Column: user.FieldID,
				},
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if n, err = sqlgraph.UpdateNodes(ctx, au.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{account.Label}
		} else if cerr, ok := isSQLConstraintError(err); ok {
			err = cerr
		}
		return 0, err
	}
	return n, nil
}

// AccountUpdateOne is the builder for updating a single Account entity.
type AccountUpdateOne struct {
	config
	hooks    []Hook
	mutation *AccountMutation
}

// SetTitle sets the title field.
func (auo *AccountUpdateOne) SetTitle(s string) *AccountUpdateOne {
	auo.mutation.SetTitle(s)
	return auo
}

// AddUserIDs adds the users edge to User by ids.
func (auo *AccountUpdateOne) AddUserIDs(ids ...int) *AccountUpdateOne {
	auo.mutation.AddUserIDs(ids...)
	return auo
}

// AddUsers adds the users edges to User.
func (auo *AccountUpdateOne) AddUsers(u ...*User) *AccountUpdateOne {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return auo.AddUserIDs(ids...)
}

// Mutation returns the AccountMutation object of the builder.
func (auo *AccountUpdateOne) Mutation() *AccountMutation {
	return auo.mutation
}

// ClearUsers clears all "users" edges to type User.
func (auo *AccountUpdateOne) ClearUsers() *AccountUpdateOne {
	auo.mutation.ClearUsers()
	return auo
}

// RemoveUserIDs removes the users edge to User by ids.
func (auo *AccountUpdateOne) RemoveUserIDs(ids ...int) *AccountUpdateOne {
	auo.mutation.RemoveUserIDs(ids...)
	return auo
}

// RemoveUsers removes users edges to User.
func (auo *AccountUpdateOne) RemoveUsers(u ...*User) *AccountUpdateOne {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return auo.RemoveUserIDs(ids...)
}

// Save executes the query and returns the updated entity.
func (auo *AccountUpdateOne) Save(ctx context.Context) (*Account, error) {
	var (
		err  error
		node *Account
	)
	if len(auo.hooks) == 0 {
		node, err = auo.sqlSave(ctx)
	} else {
		var mut Mutator = MutateFunc(func(ctx context.Context, m Mutation) (Value, error) {
			mutation, ok := m.(*AccountMutation)
			if !ok {
				return nil, fmt.Errorf("unexpected mutation type %T", m)
			}
			auo.mutation = mutation
			node, err = auo.sqlSave(ctx)
			mutation.done = true
			return node, err
		})
		for i := len(auo.hooks) - 1; i >= 0; i-- {
			mut = auo.hooks[i](mut)
		}
		if _, err := mut.Mutate(ctx, auo.mutation); err != nil {
			return nil, err
		}
	}
	return node, err
}

// SaveX is like Save, but panics if an error occurs.
func (auo *AccountUpdateOne) SaveX(ctx context.Context) *Account {
	node, err := auo.Save(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// Exec executes the query on the entity.
func (auo *AccountUpdateOne) Exec(ctx context.Context) error {
	_, err := auo.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (auo *AccountUpdateOne) ExecX(ctx context.Context) {
	if err := auo.Exec(ctx); err != nil {
		panic(err)
	}
}

func (auo *AccountUpdateOne) sqlSave(ctx context.Context) (_node *Account, err error) {
	_spec := &sqlgraph.UpdateSpec{
		Node: &sqlgraph.NodeSpec{
			Table:   account.Table,
			Columns: account.Columns,
			ID: &sqlgraph.FieldSpec{
				Type:   field.TypeInt,
				Column: account.FieldID,
			},
		},
	}
	id, ok := auo.mutation.ID()
	if !ok {
		return nil, &ValidationError{Name: "ID", err: fmt.Errorf("missing Account.ID for update")}
	}
	_spec.Node.ID.Value = id
	if value, ok := auo.mutation.Title(); ok {
		_spec.Fields.Set = append(_spec.Fields.Set, &sqlgraph.FieldSpec{
			Type:   field.TypeString,
			Value:  value,
			Column: account.FieldTitle,
		})
	}
	if auo.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   account.UsersTable,
			Columns: account.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: &sqlgraph.FieldSpec{
					Type:   field.TypeInt,
					Column: user.FieldID,
				},
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := auo.mutation.RemovedUsersIDs(); len(nodes) > 0 && !auo.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   account.UsersTable,
			Columns: account.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: &sqlgraph.FieldSpec{
					Type:   field.TypeInt,
					Column: user.FieldID,
				},
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := auo.mutation.UsersIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   account.UsersTable,
			Columns: account.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: &sqlgraph.FieldSpec{
					Type:   field.TypeInt,
					Column: user.FieldID,
				},
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	_node = &Account{config: auo.config}
	_spec.Assign = _node.assignValues
	_spec.ScanValues = _node.scanValues()
	if err = sqlgraph.UpdateNode(ctx, auo.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{account.Label}
		} else if cerr, ok := isSQLConstraintError(err); ok {
			err = cerr
		}
		return nil, err
	}
	return _node, nil
}