// Code generated by entc, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"fmt"
	server "skeleton"
	"skeleton/ent/account"
	"skeleton/ent/tag"
	"skeleton/ent/transaction"
	"skeleton/ent/user"
	"time"

	"github.com/facebook/ent/dialect/sql/sqlgraph"
	"github.com/facebook/ent/schema/field"
)

// TransactionCreate is the builder for creating a Transaction entity.
type TransactionCreate struct {
	config
	mutation *TransactionMutation
	hooks    []Hook
}

// SetDate sets the date field.
func (tc *TransactionCreate) SetDate(t time.Time) *TransactionCreate {
	tc.mutation.SetDate(t)
	return tc
}

// SetAmount sets the amount field.
func (tc *TransactionCreate) SetAmount(s server.Money) *TransactionCreate {
	tc.mutation.SetAmount(s)
	return tc
}

// SetTitle sets the title field.
func (tc *TransactionCreate) SetTitle(s string) *TransactionCreate {
	tc.mutation.SetTitle(s)
	return tc
}

// SetID sets the id field.
func (tc *TransactionCreate) SetID(i int) *TransactionCreate {
	tc.mutation.SetID(i)
	return tc
}

// SetUserID sets the user edge to User by id.
func (tc *TransactionCreate) SetUserID(id int) *TransactionCreate {
	tc.mutation.SetUserID(id)
	return tc
}

// SetNillableUserID sets the user edge to User by id if the given value is not nil.
func (tc *TransactionCreate) SetNillableUserID(id *int) *TransactionCreate {
	if id != nil {
		tc = tc.SetUserID(*id)
	}
	return tc
}

// SetUser sets the user edge to User.
func (tc *TransactionCreate) SetUser(u *User) *TransactionCreate {
	return tc.SetUserID(u.ID)
}

// SetAccountID sets the account edge to Account by id.
func (tc *TransactionCreate) SetAccountID(id int) *TransactionCreate {
	tc.mutation.SetAccountID(id)
	return tc
}

// SetNillableAccountID sets the account edge to Account by id if the given value is not nil.
func (tc *TransactionCreate) SetNillableAccountID(id *int) *TransactionCreate {
	if id != nil {
		tc = tc.SetAccountID(*id)
	}
	return tc
}

// SetAccount sets the account edge to Account.
func (tc *TransactionCreate) SetAccount(a *Account) *TransactionCreate {
	return tc.SetAccountID(a.ID)
}

// AddTagIDs adds the tags edge to Tag by ids.
func (tc *TransactionCreate) AddTagIDs(ids ...int) *TransactionCreate {
	tc.mutation.AddTagIDs(ids...)
	return tc
}

// AddTags adds the tags edges to Tag.
func (tc *TransactionCreate) AddTags(t ...*Tag) *TransactionCreate {
	ids := make([]int, len(t))
	for i := range t {
		ids[i] = t[i].ID
	}
	return tc.AddTagIDs(ids...)
}

// Mutation returns the TransactionMutation object of the builder.
func (tc *TransactionCreate) Mutation() *TransactionMutation {
	return tc.mutation
}

// Save creates the Transaction in the database.
func (tc *TransactionCreate) Save(ctx context.Context) (*Transaction, error) {
	var (
		err  error
		node *Transaction
	)
	if len(tc.hooks) == 0 {
		if err = tc.check(); err != nil {
			return nil, err
		}
		node, err = tc.sqlSave(ctx)
	} else {
		var mut Mutator = MutateFunc(func(ctx context.Context, m Mutation) (Value, error) {
			mutation, ok := m.(*TransactionMutation)
			if !ok {
				return nil, fmt.Errorf("unexpected mutation type %T", m)
			}
			if err = tc.check(); err != nil {
				return nil, err
			}
			tc.mutation = mutation
			node, err = tc.sqlSave(ctx)
			mutation.done = true
			return node, err
		})
		for i := len(tc.hooks) - 1; i >= 0; i-- {
			mut = tc.hooks[i](mut)
		}
		if _, err := mut.Mutate(ctx, tc.mutation); err != nil {
			return nil, err
		}
	}
	return node, err
}

// SaveX calls Save and panics if Save returns an error.
func (tc *TransactionCreate) SaveX(ctx context.Context) *Transaction {
	v, err := tc.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// check runs all checks and user-defined validators on the builder.
func (tc *TransactionCreate) check() error {
	if _, ok := tc.mutation.Date(); !ok {
		return &ValidationError{Name: "date", err: errors.New("ent: missing required field \"date\"")}
	}
	if _, ok := tc.mutation.Amount(); !ok {
		return &ValidationError{Name: "amount", err: errors.New("ent: missing required field \"amount\"")}
	}
	if _, ok := tc.mutation.Title(); !ok {
		return &ValidationError{Name: "title", err: errors.New("ent: missing required field \"title\"")}
	}
	if len(tc.mutation.TagsIDs()) == 0 {
		return &ValidationError{Name: "tags", err: errors.New("ent: missing required edge \"tags\"")}
	}
	return nil
}

func (tc *TransactionCreate) sqlSave(ctx context.Context) (*Transaction, error) {
	_node, _spec := tc.createSpec()
	if err := sqlgraph.CreateNode(ctx, tc.driver, _spec); err != nil {
		if cerr, ok := isSQLConstraintError(err); ok {
			err = cerr
		}
		return nil, err
	}
	if _node.ID == 0 {
		id := _spec.ID.Value.(int64)
		_node.ID = int(id)
	}
	return _node, nil
}

func (tc *TransactionCreate) createSpec() (*Transaction, *sqlgraph.CreateSpec) {
	var (
		_node = &Transaction{config: tc.config}
		_spec = &sqlgraph.CreateSpec{
			Table: transaction.Table,
			ID: &sqlgraph.FieldSpec{
				Type:   field.TypeInt,
				Column: transaction.FieldID,
			},
		}
	)
	if id, ok := tc.mutation.ID(); ok {
		_node.ID = id
		_spec.ID.Value = id
	}
	if value, ok := tc.mutation.Date(); ok {
		_spec.Fields = append(_spec.Fields, &sqlgraph.FieldSpec{
			Type:   field.TypeTime,
			Value:  value,
			Column: transaction.FieldDate,
		})
		_node.Date = value
	}
	if value, ok := tc.mutation.Amount(); ok {
		_spec.Fields = append(_spec.Fields, &sqlgraph.FieldSpec{
			Type:   field.TypeInt,
			Value:  value,
			Column: transaction.FieldAmount,
		})
		_node.Amount = value
	}
	if value, ok := tc.mutation.Title(); ok {
		_spec.Fields = append(_spec.Fields, &sqlgraph.FieldSpec{
			Type:   field.TypeString,
			Value:  value,
			Column: transaction.FieldTitle,
		})
		_node.Title = value
	}
	if nodes := tc.mutation.UserIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   transaction.UserTable,
			Columns: []string{transaction.UserColumn},
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
		_spec.Edges = append(_spec.Edges, edge)
	}
	if nodes := tc.mutation.AccountIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   transaction.AccountTable,
			Columns: []string{transaction.AccountColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: &sqlgraph.FieldSpec{
					Type:   field.TypeInt,
					Column: account.FieldID,
				},
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges = append(_spec.Edges, edge)
	}
	if nodes := tc.mutation.TagsIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   transaction.TagsTable,
			Columns: transaction.TagsPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: &sqlgraph.FieldSpec{
					Type:   field.TypeInt,
					Column: tag.FieldID,
				},
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges = append(_spec.Edges, edge)
	}
	return _node, _spec
}

// TransactionCreateBulk is the builder for creating a bulk of Transaction entities.
type TransactionCreateBulk struct {
	config
	builders []*TransactionCreate
}

// Save creates the Transaction entities in the database.
func (tcb *TransactionCreateBulk) Save(ctx context.Context) ([]*Transaction, error) {
	specs := make([]*sqlgraph.CreateSpec, len(tcb.builders))
	nodes := make([]*Transaction, len(tcb.builders))
	mutators := make([]Mutator, len(tcb.builders))
	for i := range tcb.builders {
		func(i int, root context.Context) {
			builder := tcb.builders[i]
			var mut Mutator = MutateFunc(func(ctx context.Context, m Mutation) (Value, error) {
				mutation, ok := m.(*TransactionMutation)
				if !ok {
					return nil, fmt.Errorf("unexpected mutation type %T", m)
				}
				if err := builder.check(); err != nil {
					return nil, err
				}
				builder.mutation = mutation
				nodes[i], specs[i] = builder.createSpec()
				var err error
				if i < len(mutators)-1 {
					_, err = mutators[i+1].Mutate(root, tcb.builders[i+1].mutation)
				} else {
					// Invoke the actual operation on the latest mutation in the chain.
					if err = sqlgraph.BatchCreate(ctx, tcb.driver, &sqlgraph.BatchCreateSpec{Nodes: specs}); err != nil {
						if cerr, ok := isSQLConstraintError(err); ok {
							err = cerr
						}
					}
				}
				mutation.done = true
				if err != nil {
					return nil, err
				}
				if nodes[i].ID == 0 {
					id := specs[i].ID.Value.(int64)
					nodes[i].ID = int(id)
				}
				return nodes[i], nil
			})
			for i := len(builder.hooks) - 1; i >= 0; i-- {
				mut = builder.hooks[i](mut)
			}
			mutators[i] = mut
		}(i, ctx)
	}
	if len(mutators) > 0 {
		if _, err := mutators[0].Mutate(ctx, tcb.builders[0].mutation); err != nil {
			return nil, err
		}
	}
	return nodes, nil
}

// SaveX calls Save and panics if Save returns an error.
func (tcb *TransactionCreateBulk) SaveX(ctx context.Context) []*Transaction {
	v, err := tcb.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}
