package api

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"github.com/gin-gonic/gin/binding"
	"github.com/go-playground/validator/v10"
	db "github.com/vish9812/mybank/db/sqlc"
	"github.com/vish9812/mybank/token"
	"github.com/vish9812/mybank/util"
)

type Server struct {
	config     *util.Config
	tokenMaker token.Maker
	store      db.Store
	router     *gin.Engine
}

func NewServer(config *util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("can not create token maker: %w", err)
	}
	server := &Server{
		config:     config,
		tokenMaker: tokenMaker,
		store:      store,
	}

	if validator, ok := binding.Validator.Engine().(*validator.Validate); ok {
		validator.RegisterValidation("currency", validCurrency)
	}

	server.setupRouter()
	return server, nil
}

func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}
