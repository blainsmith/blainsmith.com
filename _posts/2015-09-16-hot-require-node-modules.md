---
layout: post
title: 'Hot "require" Node Modules'
image: /assets/article_images/require-node-modules.jpg
---
Under normal circumstances when writing node apps all dependencies and code are packaged in the repo and deployed. Modifying any part of the app requires you to deploy again and reboot the server. However, I needed a way to [hot require](https://en.wikipedia.org/wiki/Hot_swapping) javascript code and execute it while the app was running so there would not be any downtime. I was able to achieve this using node core's [modules API](https://nodejs.org/api/modules.html) to fetch a string of javascript from a database and execute it within the context of my node app.

Lets say we have a collection in our database with an entry that looks like the following:

#### MongoDB Record

```json
{
  "_id": "my-function",
  "fn": "module.exports = function(ctx, args, callback) { ctx.db.users.find({ lastName: args.lastName }, function(err, result) { if (err) { return done(err); } var result = 'Hello there, ' + args.firstName + '!!! There are ' + result.length + ' with the same last name as you!'; return callback(null, result); }); };",
  "createdAt": "2012-10-15T21:26:17Z"
}
```

#### 'fn' Field Prettified

```js
module.exports = function(ctx, args, callback) {
  // Get all users with the lastName and add the count of them to the string
  ctx.db.users.find({ lastName: args.lastName }, function(err, result) {
    if (err) { return done(err); }

    var result = 'Hello there, ' + args.firstName + '!!! There are ' + result.length + ' with the same last name as you!';

    return callback(null, result);
  });
};
```

#### app.js

```js
// Global context of varables available to our function
var ctx = {
  db: db,
  foo: 'bar'
};

// First, fetch the record from the db with id = my-function
db.functionsCollection.find({ id: 'my-function' }, function(err, result) {

  // Create an instance of a node module
  var fnModule = new module.constructor();

  // Compile the string from db into that new module
  fnModule._compile(result.fn, result.id);

  // Assign a variable to the compiled function
  var myFunction = fnModule.exports;

  // Use the function
  myFunction(ctx, { firstName: 'Blain', lastName: 'Smith' }, function(err, result) {
    console.log(result); // Outputs 'Hello there, Blain!!! There are 13 with the same last name as you!'
  });
});
```

I am using this for dynamic data aggregators so I can add new ones to the system without redeploying new code every time I want to add one. I also made a wrapper around this to make loading these function with a single call like:

```js
var myFunction = hotRequire('my-function');
```

**Disclaimer: This is really powerful and also dangerous if used incorrectly so use with caution.**
