package handler

import (
	"encoding/json"
	"fmt"
	"github.com/liip/sheriff"
	"github.com/masseelch/render"
	"net/http"
	"skeleton/auth"
	"skeleton/ent"
	"skeleton/ent/account"
	"skeleton/ent/transaction"
	"skeleton/ent/user"
)

func (h AccountHandler) Meta(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()

	s := auth.SessionFromContext(ctx)

	as, err := h.client.Account.Query().
		Where(
			account.HasUsersWith(
				user.ID(s.Edges.User.ID),
			),
		).
		WithTransactions(func(q *ent.TransactionQuery) {
			q.WithUser().Order(ent.Desc(transaction.FieldDate)).Limit(10)
		}).
		All(r.Context())

	if err != nil {
		h.logger.WithError(err).Error("error querying database") // todo - better error
		render.InternalServerError(w, r, nil)
		return
	}

	asdasd, _ := json.MarshalIndent(as, "", "  ")
	fmt.Println(string(asdasd))

	d, err := sheriff.Marshal(&sheriff.Options{Groups: []string{"account:list", "transaction:list", "user:list"}}, as)
	if err != nil {
		h.logger.WithError(err).Error("serialization error")
		render.InternalServerError(w, r, nil)
		return
	}

	h.logger.WithField("amount", len(as)).Info("accounts rendered")
	render.OK(w, r, d)
}
