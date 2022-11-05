package main

import (
	"database/sql"
	"log"

	_ "github.com/golang/mock/mockgen/model"
	_ "github.com/lib/pq"

	"github.com/vish9812/mybank/api"
	db "github.com/vish9812/mybank/db/sqlc"
	"github.com/vish9812/mybank/util"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("Can not load config:", err)
	}

	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("can not connect to DB:", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("can not create server: ", err)
	}

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("can not start server:", err)
	}
}
