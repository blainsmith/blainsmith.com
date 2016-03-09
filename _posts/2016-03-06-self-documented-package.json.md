---
layout: post
title: 'Self-Documented package.json'
---
I read a google article the other day about a [self-documented Makefile](http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html). The TL;DR is you can add comments to each of the commands in the `Makefile`. Then by just running `make` from the command line it will print both the command and the associated comment to explain the entire `Makefile` at a quick glance. Not only is this very helpful, but it also rids your `README` of this shit you constantly having to keep updated:

### Running

```
$ npm install
$ npm run dev
```

### Testing and Linting

```
$ npm run linter
$ npm test
```

Then when you add another script to `package.json` you have to update your `README` to document it...if you remember to.

Instead you can take a lesson from the `Makefile` article above and add some inline comments to your npm scripts.

**package.json**

```json
"scripts": {
  "dev": "### Start the server in dev mode and watch for file changes\n    nodemon index.js -e js,json",
  "test": "### Run the linter and test suite\n    npm run lint && npm run tape ",
  "tape": "### Run just the test suite\n    tape 'test/**/*_test.js' | tap-spec",
  "lint": "### Run just the linter\n    xo",
  "start": "### Start the server in production mode\n    node index.js -e js,json",
  "sec": "### Security check the packages\n    ./node_modules/.bin/nsp check -o json --warn-only"
},
```

This is what you get now when you just run `npm run`.

```
$ npm run
Lifecycle scripts included in npm-test-project:
  test
    ### Run the linter and test suite
    npm run lint && npm run tape
  start
    ### Start the server in production mode
    node index.js

available via `npm run-script`:
  dev
    ### Start the server in dev mode and watch for file changes
    nodemon index.js
  tape
    ### Run just the test suite
    tape 'test/**/*_test.js' | tap-spec
  lint
    ### Run just the linter
    xo
  sec
    ### Security check the packages
    ./node_modules/.bin/nsp check -o json --warn-only
```

By wrapping the documentation text between a `#` and `\n` (newline) character it will display the text and still allow the actual command to run. You can go a little crazier and add `\t` (tab) characters and even emojis to make it really awesome.


```
$ npm run
Lifecycle scripts included in npm-test-project:
  test
    # 🚦  Run the linter and test suite
    npm run lint && npm run tape
  start
    # 🚀  Start the server in production mode
    node index.js -e js,json

available via `npm run-script`:
  dev
    # 🖥  Start the server in dev mode and watch for file changes
    nodemon index.js -e js,json
  tape
    # ⭕️  Run just the test suite
    tape 'test/**/*_test.js' | tap-spec
  lint
    # ⭕️  Run just the linter
    xo
  sec
    # 🔒  Security check the packages
    ./node_modules/.bin/nsp check -o json --warn-only
```

Now you can clean up your `README` file and add all the proper documentation to the `package.json` file where it belongs.

If you have any other tricks about this [send me a PR](http://github.com/blainsmith/blainsmith.github.io) for this article and I will update it!
