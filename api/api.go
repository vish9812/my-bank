package api

import "github.com/gin-gonic/gin"

func (server *Server) setupRouter() {
	router := gin.Default()
	// accounts
	router.POST("/users/login", server.loginUser)
	router.POST("/users", server.createUser)
	router.GET("/users/:username", server.getUser)

	// accounts
	router.POST("/accounts", server.createAccount)
	router.GET("/accounts/:id", server.getAccount)
	router.GET("/accounts", server.getAccounts)

	// transfers
	router.POST("/transfers", server.createTransfer)

	server.router = router
}
