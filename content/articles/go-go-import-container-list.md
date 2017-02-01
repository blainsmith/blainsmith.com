---
date: 2017-02-01T00:00:00Z
title: Go, Go import "container/list"!
---

On a few different occasions I've needed to keep a registry of interface implementations to iterate over later on. The first time I did it was to have define an `EventWriter` interface.

```go
// writers/writers.go

package writers

type Event stuct {
  Action    string `json:"action"`
  Details   string `json:"details"`
  CreatedAt string `json:"createdAt"`
}

type EventWriter interface {
  WriteEvent(event Event)
}

var Writers []EventWriter

func Add(writer EventWriter) {
  Writers = append(Writers, writer)
}
```

Elsewhere, in my program I initialized a few implementations of `EventWriter` and added them to the list of available ones. This is a stupid use, but for the sake of explaining I show it this way. My actual use was handling HTTP POST requests and so this really lives in a handler.

```go
// main.go

package main

import (
  "sync"
  "writer-app/writers"
)

func init() {
  // Add a bunch of EventWriter implementations to the registry
  writers.Add(&mySQLWriter{})
  writers.Add(&s3Writer{})
  writers.Add(&boltDBWriter{})
}

func main() {
  event := &writers.Event{"load", "the app loaded", "2017-02-01T00:00:00Z"}

  // Loop over the slice that is the registry and call WriteEvent on each one
  for _, writer := range writers.Writers {
    writer.WriteEvent(event)
  }
}
```

While this proved effective and worked perfectly fine it isn't very idiomatic in Go. It also felt very dirty to me so I looked around for a better way to handle this. I immediately went into the Go standard library because it seems to always have what I need. In this cases I needed something like a slice, but with some methods to make working with the underlying elements nicer. As it turns out Go has a `container/list` [^1] package that does exactly what I wanted to have this registry pattern I could work with.

Refactoring the interface file I now have:

```go
// writers/writers.go

package writers

import (
  "container/list"
)

var Registry = list.New()

type Event stuct {
  Action    string `json:"action"`
  Details   string `json:"details"`
  CreatedAt string `json:"createdAt"`
}

type EventWriter interface {
  WriteEvent(event Event)
}
```

And now for using the `Registry` list in my main program I have just a standard `list.List` provided by the standard library, which is an implementation of a doubly linked list [^2] data structure. I also get all the documentation around this as well so that the next developer that looks at this can understand this a lot quicker.

One thing to notice when I call `WriteEvent` within the loop is that I need to cast the `writer.Value`, into an actual `Writer`. That is because `list.List` works with `interface{}` types as you can see from the documentation.

```go
// main.go

package main

import (
  "sync"
  "writer-app/writers"
)

func init() {
  // Add a bunch of EventWriter implementations to the registry
  writers.Registry.PushFront(&mySQLWriter{})
  writers.Registry.PushFront(&s3Writer{})
  writers.Registry.PushFront(&boltDBWriter{})
}

func main() {
  event := &writers.Event{"load", "the app loaded", "2017-02-01T00:00:00Z"}

  // Loop over the list that is the registry and call WriteEvent on each one
  for writer := Registry.Front(); writer != nil; writer = writer.Next() {
    // Convert the Value to an actual Writer
    writer.Value.(Writer).WriteEvent(event)
  }
}
```

This seems like a trivial example, but it shows how nice the Go standard library is by providing this out of the box instead of having to implement my own every time.

**References**

- container/list GoDoc: https://golang.org/pkg/container/list/  
- Doubly Linked List: https://en.wikipedia.org/wiki/Doubly_linked_list  
