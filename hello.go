package main

import (
	"fmt"
	"log"
	"net/http"
	"runtime"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hi Folks, I'm running on a %s instance!", runtime.GOARCH)
}

func main() {
	fmt.Println("Starting webserver on port: 8080")
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

