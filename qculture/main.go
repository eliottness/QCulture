package main

import "github.com/gin-gonic/gin"

/// Setup the router the routes, templates location and static files
func SetupRouter() *gin.Engine {
	router := gin.Default()
	router.GET("/ping", pingGET)
	return router
}

func main() {
	router := SetupRouter()
	router.Run()
}
