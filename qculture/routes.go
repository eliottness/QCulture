package main

import "github.com/gin-gonic/gin"

func pingGET(c *gin.Context) {
	c.String(200, "pong")
}
