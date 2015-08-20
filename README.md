[<img src="https://www.mongodb.org/static/images/mongodb-logo-large.png" width="280px" alt="MongoDB logo">](http://www.mongodb.org)

[<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Smit.m.rhinogale.melleri.jpg/120px-Smit.m.rhinogale.melleri.jpg" width="120px" alt="Mongoose">](http://mongoosejs.com/)

[<img src="http://haxe.org/img/haxe-logo-horizontal.svg" alt="Haxe logo" width="140">](http://haxe.org)

[<img src="http://nodejs.org/images/logos/nodejs.png" width="140px" alt="nodejs logo">](http://nodejs.org)





# HxMongo

### Overview

Extern classes for Mongoose and MongoDB nodejs driver.  

### Installation

* Install and make available in the command line **[NodeJS](http://nodejs.org/)**
* Create a Javascript project.
* Run `haxelib install HxMongo` (once this lib has been added to haxelib)

### Build and Run

* See the quickstart guide below.
* The installations should make all necessary tools available.
* Develop your application and compile it in a `.js`
* Run `nodejs your_app.js` and you are done!
 
### Dependencies

* This package needs `NPM` manager: **(remember to install)**
  * `mongodb`
  * `mongoose` (optional)

### QuickStart

[MongoDB driver quickstart guide](http://mongodb.github.io/node-mongodb-native/2.0/)
[Mongoose quickstart guide](http://mongoosejs.com/docs/index.html)

### Test app

* [Install MongoDB](http://docs.mongodb.org/manual/installation/).
* Edit `src/com/dal/mongotest/MongoTest.hx` with your server domain and user credentials.
* Run `haxelib git hxnodejs https://github.com/HaxeFoundation/hxnodejs.git master`
* Run `haxelib install promhx`
* Make sure you have the necessary compilers. e.g. For Ubuntu: `sudo apt-get install build-essential`
* Within "test/build" directory run `npm install` to fetch and build native MongoDB driver for node.js
* Run `haxe build.hxml`
* From the "test/build" directory run `node main.js`
