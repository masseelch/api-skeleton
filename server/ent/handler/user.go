package handler

import (
	"github.com/liip/sheriff"
	"github.com/masseelch/render"
	"net/http"
	"skeleton/ent"
	"skeleton/ent/account"
	"skeleton/ent/transaction"
	"skeleton/ent/user"
)

type metaResponse []struct {
	Account             ent.Account `json:"account"`
	AccumulatedExpenses int         `json:"accumulated_expenses"`
}

func (h UserHandler) Meta(w http.ResponseWriter, r *http.Request) {
	id, err := h.urlParamInt(w, r, "id")
	if err != nil {
		return
	}

	from, err := h.urlParamTime(w, r, "from")
	if err != nil {
		return
	}

	to, err := h.urlParamTime(w, r, "to")
	if err != nil {
		return
	}

	as, err := h.client.Account.Query().
		Where(
			account.HasUsersWith(
				user.ID(id),
			),
		).
		WithTransactions(func(q *ent.TransactionQuery) {
			q.WithUser().Order(ent.Desc(transaction.FieldDate)).Where(
				transaction.DateGTE(from),
				transaction.DateLT(to),
			)
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
