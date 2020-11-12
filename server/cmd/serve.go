/*
Copyright © 2020 MasseElch <info@masseelch.de>

*/
package cmd

import (
	"fmt"
	"log"
	"net/http"
	"skeleton/auth"
	"skeleton/ent"
	"skeleton/ent/handler"
	"skeleton/util"
	"time"

	"github.com/facebook/ent/dialect/sql"
	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	_ "github.com/go-sql-driver/mysql"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

// migrateCmd represents the migrate command
var serveCmd = &cobra.Command{
	Use: "serve",
	// todo
	Run: func(cmd *cobra.Command, args []string) {
		p, err := cmd.Flags().GetInt("port")
		if err != nil {
			panic(err)
		}

		// Get a database connection for ent.
		drv, err := sql.Open("mysql", util.MysqlDSN())
		if err != nil {
			panic(err)
		}
		defer drv.Close()
		drv.DB().SetConnMaxLifetime(time.Second)
		c := ent.NewClient(ent.Driver(drv))

		// Create a validator.
		v := util.Validator()

		// Create a logger.
		l := logrus.New()

		r := chi.NewRouter()
		r.Use(
			middleware.DefaultLogger, // todo - replace with logrus
		)

		r.Route("/auth", func(r chi.Router) {
			r.Post("/token", auth.LoginHandler(c, v, l))
		})

		r.Group(func(r chi.Router) {
			r.Use(auth.Middleware(c, l))

			r.Mount("/users", handler.NewUserHandler(c, v, l).EnableAllEndpoints())

			// Accounts
			accountHandler := handler.NewAccountHandler(c, v, l).EnableAllEndpoints()
			accountHandler.Get("/{id:\\d+}/meta", accountHandler.Meta)
			r.Mount("/accounts", accountHandler)
		})

		log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", p), r))
	},
}

func init() {
	rootCmd.AddCommand(serveCmd)

	serveCmd.Flags().IntP("port", "p", 8000, "port to listen on")
}
