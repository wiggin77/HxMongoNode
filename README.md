![](http://i.imgur.com/gsd2DdK.png)
# Haxe NodeJS

### Overview

Extern classes for nodejs.  
They follow the canonic names found in the **[API](http://nodejs.org/api/index.html)**.  
Some classes (like URL) have features better grouped.  
Probably there will be missing commands and methods.  

 **I'm doing this library as helper for my main projects so it will evolve according to my needs**

### Installation

* Install **[FlashDevelop](http://www.flashdevelop.org/community/viewforum.php?f=11) (not obligatory)**
* Install and make available in the command line **[NodeJS](http://nodejs.org/)**
* Create a Javascript project.
* Run `haxelib install nodehx`

### Build and Run

* The installations should make all necessary tools available.
* Develop your application and compile it in a `.js`
* Run `nodejs your_app.js` and you are done!
 
### Dependencies

* Some classes needs `NPM` packages like: **(remember to install them)**
    * `mongodb`
    * `peerjs-server`
    * `nodewebkit`
    * `multiparty` (upload support for webservices)
    * `express`
