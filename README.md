[<img src="http://www.mongodb.com/sites/mongodb.com/files/media/mongodb-logo-rgb.jpeg" width="280px" alt="MongoDB logo">](http://www.mongodb.org)

[<img src="http://haxe.org/img/haxe-logo-horizontal.svg" alt="Haxe logo" width="140">](http://haxe.org)

[<img src="http://nodejs.org/images/logos/nodejs.png" width="140px" alt="nodejs logo">](http://nodejs.org)

# Haxe MongoDB for node.js

### Overview

Extern classes for MongoDB nodejs driver.  

### Installation

* Install and make available in the command line **[NodeJS](http://nodejs.org/)**
* Create a Javascript project.
* Run `haxelib install hxmongodb` (once this lib has been added to haxelib)

### Build and Run

* See the quickstart guide below.
* The installations should make all necessary tools available.
* Develop your application and compile it in a `.js`
* Run `nodejs your_app.js` and you are done!
 
### Dependencies

* This package needs `NPM` manager: **(remember to install)**
  * `mongodb`

### QuickStart

[MongoDB driver quickstart guide](http://mongodb.github.io/node-mongodb-native/2.0/)

### Test app

* [Install MongoDB](http://docs.mongodb.org/manual/installation/).
* Edit `src/com/dal/mongotest/MongoTest.hx` with your server domain and user credentials.
* Run `haxelib git hxnodejs https://github.com/HaxeFoundation/hxnodejs.git master`
* Within "test/build" directory run `npm install` to fetch and build native MongoDB driver for node.js
* Run `haxe build.hxml`
* From the "test/build" directory run `node main.js`
