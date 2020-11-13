package handler

import (
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
	u := auth.UserFromContext(ctx)

	as, err := h.client.Account.Query().
		Where(
			account.HasUsersWith(
				user.ID(u.ID),
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

	d, err := sheriff.Marshal(&sheriff.Options{Groups: []string{"account:list", "transaction:list", "user:list"}}, as)
	if err != nil {
		h.logger.WithError(err).Error("serialization error")
		render.InternalServerError(w, r, nil)
		return
	}

	h.logger.WithField("amount", len(as)).Info("accounts rendered")
	render.OK(w, r, d)
}
