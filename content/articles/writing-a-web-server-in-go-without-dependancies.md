---
date: 2019-01-29T00:00:00Z
title: Writing a Web Server in Go without Dependancies
draft: true
---

I recently came across a good article on doing this exact exercise in Node.js. As I am sure there are other blog posts covering this topic in Go, I really liked the format the author took when writing the Node.js version so I wanted to use that for a Go version. Additionally, a [friend of mine](https://www.bater.io) expressed interest in writing a small web server in Go for a home project and he inquired about being able to do so with just the Go standard library. So here it is.

## Table of Contents

1. Hello, World

## Hello, World

Here is the simplest "hello, world" web server in Go just using the [`net/http`](https://golang.org/pkg/net/http/) package.

```go
package main

import (
	"net/http"
	"os"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = ":8080"
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello, world!"))
	})

	http.ListenAndServe(port, nil)
}
```

In this example we do 3 very simple things.

1. Read the `PORT` environment variable and set a default if it was empty.
2. Created a handler to accept incoming requests.
3. Started listening for connections on the `port` specified.

