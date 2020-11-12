/*
Copyright © 2020 MasseElch <info@masseelch.de>

*/
package cmd

import (
	"skeleton/ent"
	"skeleton/fixtures"
	"skeleton/util"

	_ "github.com/go-sql-driver/mysql"
	"github.com/spf13/cobra"
)

// fixturesCmd represents the fixtures command
var fixturesCmd = &cobra.Command{
	Use: "fixtures",
	// todo
	Run: func(cmd *cobra.Command, args []string) {
		c, err := ent.Open("mysql", util.MysqlDSN())
		if err != nil {
			panic(err)
		}
		defer c.Close()

		if err := fixtures.Load(c); err != nil {
			panic(err) // todo
		}
	},
}

func init() {
	databaseCmd.AddCommand(fixturesCmd)
}
