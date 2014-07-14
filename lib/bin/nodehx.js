(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
};
js.Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js.Boot.__interfLoop(js.Boot.getClass(o),cl)) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
var nodejs = {};
nodejs.ChildProcessEventType = function() { };
nodejs.ChildProcessEventType.__name__ = true;
nodejs.NodeJS = function() { };
nodejs.NodeJS.__name__ = true;
nodejs.NodeJS.get_dirname = function() {
	return __dirname;
};
nodejs.NodeJS.get_filename = function() {
	return __filename;
};
nodejs.NodeJS.require = function(p_lib) {
	return require(p_lib);
};
nodejs.NodeJS.get_process = function() {
	return process;
};
nodejs.NodeJS.setTimeout = function(cb,ms) {
	return setTimeout(cb,ms);
};
nodejs.NodeJS.clearTimeout = function(t) {
	return clearTimeout(t);
};
nodejs.NodeJS.setInterval = function(cb,ms) {
	return setInterval(cb,ms);
};
nodejs.NodeJS.clearInterval = function(t) {
	return clearInterval(t);
};
nodejs.NodeJS.assert = function(value,message) {
	require('assert')(value,message);
};
nodejs.NodeJS.get_global = function() {
	return global;
};
nodejs.NodeJS.resolve = function() {
	return require.resolve();
};
nodejs.NodeJS.get_cache = function() {
	return require.cache;
};
nodejs.NodeJS.get_extensions = function() {
	return require.extensions;
};
nodejs.NodeJS.get_module = function() {
	return module;
};
nodejs.NodeJS.get_exports = function() {
	return exports;
};
nodejs.NodeJS.get_domain = function() {
	return domain.create();
};
nodejs.NodeJS.get_repl = function() {
	return require('repl');
};
nodejs.ProcessEventType = function() { };
nodejs.ProcessEventType.__name__ = true;
nodejs.REPLEventType = function() { };
nodejs.REPLEventType.__name__ = true;
nodejs.authom = {};
nodejs.authom.AuthomEventType = function() { };
nodejs.authom.AuthomEventType.__name__ = true;
nodejs.crypto = {};
nodejs.crypto.CryptoAlgorithm = function() { };
nodejs.crypto.CryptoAlgorithm.__name__ = true;
nodejs.events = {};
nodejs.events.EventEmitterEventType = function() { };
nodejs.events.EventEmitterEventType.__name__ = true;
nodejs.express = {};
nodejs.express.Express = function() { };
nodejs.express.Express.__name__ = true;
nodejs.express.Express.GetApplication = function() {
	return require('express')();
};
nodejs.express.Express.GetRouter = function(p_case_sensitive,p_strict) {
	if(p_strict == null) p_strict = false;
	if(p_case_sensitive == null) p_case_sensitive = false;
	var opt = { };
	opt.caseSensitive = p_case_sensitive;
	opt.strict = p_strict;
	return require('express').Router(opt);
};
nodejs.express.Express.Static = function(p_value) {
	return (require('express')).static(p_value);
};
nodejs.fs = {};
nodejs.fs.FSWatcherEventType = function() { };
nodejs.fs.FSWatcherEventType.__name__ = true;
nodejs.fs.FileLinkType = function() { };
nodejs.fs.FileLinkType.__name__ = true;
nodejs.fs.FileIOFlag = function() { };
nodejs.fs.FileIOFlag.__name__ = true;
nodejs.fs.ReadStreamEventType = function() { };
nodejs.fs.ReadStreamEventType.__name__ = true;
nodejs.fs.WriteStreamEventType = function() { };
nodejs.fs.WriteStreamEventType.__name__ = true;
nodejs.http = {};
nodejs.http.HTTPMethod = function() { };
nodejs.http.HTTPMethod.__name__ = true;
nodejs.http.HTTPClientRequestEventType = function() { };
nodejs.http.HTTPClientRequestEventType.__name__ = true;
nodejs.http.HTTPServerEventType = function() { };
nodejs.http.HTTPServerEventType.__name__ = true;
nodejs.stream = {};
nodejs.stream.ReadableEventType = function() { };
nodejs.stream.ReadableEventType.__name__ = true;
nodejs.http.IncomingMessageEventType = function() { };
nodejs.http.IncomingMessageEventType.__name__ = true;
nodejs.http.IncomingMessageEventType.__super__ = nodejs.stream.ReadableEventType;
nodejs.http.IncomingMessageEventType.prototype = $extend(nodejs.stream.ReadableEventType.prototype,{
	__class__: nodejs.http.IncomingMessageEventType
});
nodejs.http.MultipartFormEventType = function() { };
nodejs.http.MultipartFormEventType.__name__ = true;
nodejs.http.ServerResponseEventType = function() { };
nodejs.http.ServerResponseEventType.__name__ = true;
nodejs.http.URL = function() { };
nodejs.http.URL.__name__ = true;
nodejs.http.URL.get_url = function() {
	if(nodejs.http.URL.m_url == null) return nodejs.http.URL.m_url = nodejs.NodeJS.require("url"); else return nodejs.http.URL.m_url;
};
nodejs.http.URL.get_qs = function() {
	if(nodejs.http.URL.m_qs == null) return nodejs.http.URL.m_qs = nodejs.NodeJS.require("querystring"); else return nodejs.http.URL.m_qs;
};
nodejs.http.URL.get_mp = function() {
	if(nodejs.http.URL.m_mp == null) return nodejs.http.URL.m_mp = nodejs.NodeJS.require("multiparty"); else return nodejs.http.URL.m_mp;
};
nodejs.http.URL.Parse = function(p_url) {
	var d = nodejs.http.URL.get_url().parse(p_url);
	return d;
};
nodejs.http.URL.ParseQuery = function(p_query,p_separator,p_assigment,p_max_keys) {
	if(p_max_keys == null) p_max_keys = 1000;
	if(p_assigment == null) p_assigment = "=";
	if(p_separator == null) p_separator = "&";
	if(p_query == null) return { };
	if(p_query == "") return { };
	return nodejs.http.URL.get_qs().parse(p_query,p_separator,p_assigment,{ maxKeys : p_max_keys});
};
nodejs.http.URL.ToQuery = function(p_target,p_separator,p_assigment) {
	if(p_assigment == null) p_assigment = "=";
	if(p_separator == null) p_separator = "&";
	if(p_target == null) return "null";
	return nodejs.http.URL.get_qs().stringify(p_target,p_separator,p_assigment);
};
nodejs.http.URL.ParseMultipart = function(p_request,p_callback,p_options) {
	var opt;
	if(p_options == null) opt = { }; else opt = p_options;
	var multipart = nodejs.http.URL.get_mp();
	var options = opt;
	var f = new multipart.Form(opt);
	if(p_callback == null) try {
		f.parse(p_request);
	} catch( e ) {
		if( js.Boot.__instanceof(e,Error) ) {
			console.log("URL> " + Std.string(e) + "\n\t" + e.stack);
		} else throw(e);
	} else try {
		f.parse(p_request,p_callback);
	} catch( e1 ) {
		console.log("!!! " + Std.string(e1));
	}
	return f;
};
nodejs.http.URL.Resolve = function(p_from,p_to) {
	return nodejs.http.URL.get_url().resolve(p_from,p_to);
};
nodejs.mongodb = {};
nodejs.mongodb.CursorStreamEvent = function() { };
nodejs.mongodb.CursorStreamEvent.__name__ = true;
nodejs.mongodb.MongoAuthOption = function() {
	this.authMechanism = "MONGODB - CR";
};
nodejs.mongodb.MongoAuthOption.__name__ = true;
nodejs.mongodb.MongoAuthOption.prototype = {
	__class__: nodejs.mongodb.MongoAuthOption
};
nodejs.mongodb.ReadStreamEvent = function() { };
nodejs.mongodb.ReadStreamEvent.__name__ = true;
nodejs.net = {};
nodejs.net.TCPServerEventType = function() { };
nodejs.net.TCPServerEventType.__name__ = true;
nodejs.net.TCPSocketEventType = function() { };
nodejs.net.TCPSocketEventType.__name__ = true;
nodejs.nw = {};
nodejs.nw.AppEventType = function() { };
nodejs.nw.AppEventType.__name__ = true;
nodejs.nw.App = function() { };
nodejs.nw.App.__name__ = true;
nodejs.nw.App.get_instance = function() {
	return require('nw.gui').App;
};
nodejs.nw.MenuType = function() { };
nodejs.nw.MenuType.__name__ = true;
nodejs.nw.MenuItemType = function() { };
nodejs.nw.MenuItemType.__name__ = true;
nodejs.peerjs = {};
nodejs.peerjs.WRTCServerEventType = function() { };
nodejs.peerjs.WRTCServerEventType.__name__ = true;
nodejs.stream.WritableEventType = function() { };
nodejs.stream.WritableEventType.__name__ = true;
nodejs.tls = {};
nodejs.tls.CleartextStreamEventType = function() { };
nodejs.tls.CleartextStreamEventType.__name__ = true;
nodejs.tls.SecurePairEventType = function() { };
nodejs.tls.SecurePairEventType.__name__ = true;
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
nodejs.ChildProcessEventType.Disconnect = "disconnect";
nodejs.ChildProcessEventType.Error = "error";
nodejs.ChildProcessEventType.Close = "close";
nodejs.ChildProcessEventType.Message = "message";
nodejs.ChildProcessEventType.Exit = "exit";
nodejs.ProcessEventType.Exit = "exit";
nodejs.ProcessEventType.Exception = "uncaughtException";
nodejs.REPLEventType.Exit = "exit";
nodejs.authom.AuthomEventType.Auth = "auth";
nodejs.authom.AuthomEventType.Error = "error";
nodejs.crypto.CryptoAlgorithm.SHA1 = "sha1";
nodejs.crypto.CryptoAlgorithm.MD5 = "md5";
nodejs.crypto.CryptoAlgorithm.SHA256 = "sha256";
nodejs.crypto.CryptoAlgorithm.SHA512 = "sha512";
nodejs.events.EventEmitterEventType.NewListener = "newListener";
nodejs.events.EventEmitterEventType.RemoveListener = "removeListener";
nodejs.fs.FSWatcherEventType.Change = "change";
nodejs.fs.FSWatcherEventType.Error = "error";
nodejs.fs.FileLinkType.Dir = "dir";
nodejs.fs.FileLinkType.File = "file";
nodejs.fs.FileLinkType.Junction = "junction";
nodejs.fs.FileIOFlag.Read = "r";
nodejs.fs.FileIOFlag.ReadWrite = "r+";
nodejs.fs.FileIOFlag.ReadSync = "rs";
nodejs.fs.FileIOFlag.ReadWriteSync = "rs+";
nodejs.fs.FileIOFlag.WriteCreate = "w";
nodejs.fs.FileIOFlag.WriteCheck = "wx";
nodejs.fs.FileIOFlag.WriteReadCreate = "w+";
nodejs.fs.FileIOFlag.WriteReadCheck = "wx+";
nodejs.fs.FileIOFlag.AppendCreate = "a";
nodejs.fs.FileIOFlag.AppendCheck = "ax";
nodejs.fs.FileIOFlag.AppendReadCreate = "a+";
nodejs.fs.FileIOFlag.AppendReadCheck = "ax+";
nodejs.fs.ReadStreamEventType.Open = "open";
nodejs.fs.WriteStreamEventType.Open = "open";
nodejs.http.HTTPMethod.Get = "GET";
nodejs.http.HTTPMethod.Post = "POST";
nodejs.http.HTTPMethod.Options = "OPTIONS";
nodejs.http.HTTPMethod.Head = "HEAD";
nodejs.http.HTTPMethod.Put = "PUT";
nodejs.http.HTTPMethod.Delete = "DELETE";
nodejs.http.HTTPMethod.Trace = "TRACE";
nodejs.http.HTTPMethod.Connect = "CONNECT";
nodejs.http.HTTPServerEventType.Listening = "listening";
nodejs.http.HTTPServerEventType.Connection = "connection";
nodejs.http.HTTPServerEventType.Close = "close";
nodejs.http.HTTPServerEventType.Error = "error";
nodejs.http.HTTPServerEventType.Request = "request";
nodejs.http.HTTPServerEventType.CheckContinue = "checkContinue";
nodejs.http.HTTPServerEventType.Connect = "connect";
nodejs.http.HTTPServerEventType.Upgrade = "upgrade";
nodejs.http.HTTPServerEventType.ClientError = "clientError";
nodejs.stream.ReadableEventType.Readable = "readable";
nodejs.stream.ReadableEventType.Data = "data";
nodejs.stream.ReadableEventType.End = "end";
nodejs.stream.ReadableEventType.Close = "close";
nodejs.stream.ReadableEventType.Error = "error";
nodejs.http.IncomingMessageEventType.Data = "data";
nodejs.http.IncomingMessageEventType.Close = "close";
nodejs.http.IncomingMessageEventType.End = "end";
nodejs.http.MultipartFormEventType.Part = "part";
nodejs.http.MultipartFormEventType.Aborted = "aborted";
nodejs.http.MultipartFormEventType.Error = "error";
nodejs.http.MultipartFormEventType.Progress = "progress";
nodejs.http.MultipartFormEventType.Field = "field";
nodejs.http.MultipartFormEventType.File = "file";
nodejs.http.MultipartFormEventType.Close = "close";
nodejs.http.ServerResponseEventType.Close = "close";
nodejs.http.ServerResponseEventType.Finish = "finish";
nodejs.mongodb.CursorStreamEvent.Data = "data";
nodejs.mongodb.CursorStreamEvent.Close = "close";
nodejs.mongodb.CursorStreamEvent.Error = "error";
nodejs.mongodb.MongoAuthOption.MONGO_CR = "MONGODB - CR";
nodejs.mongodb.MongoAuthOption.GSSAPI = "GSSAPI";
nodejs.mongodb.ReadStreamEvent.Data = "data";
nodejs.mongodb.ReadStreamEvent.End = "end";
nodejs.mongodb.ReadStreamEvent.Close = "close";
nodejs.mongodb.ReadStreamEvent.Error = "error";
nodejs.net.TCPServerEventType.Listening = "listening";
nodejs.net.TCPServerEventType.Connection = "connection";
nodejs.net.TCPServerEventType.Close = "close";
nodejs.net.TCPServerEventType.Error = "error";
nodejs.net.TCPSocketEventType.Connect = "connect";
nodejs.net.TCPSocketEventType.Data = "data";
nodejs.net.TCPSocketEventType.End = "end";
nodejs.net.TCPSocketEventType.TimeOut = "timeout";
nodejs.net.TCPSocketEventType.Drain = "drain";
nodejs.net.TCPSocketEventType.Error = "error";
nodejs.net.TCPSocketEventType.Close = "close";
nodejs.nw.AppEventType.Open = "open";
nodejs.nw.AppEventType.Reopen = "reopen";
nodejs.nw.MenuType.Menubar = "menubar";
nodejs.nw.MenuItemType.Separator = "separator";
nodejs.nw.MenuItemType.Checkbox = "checkbox";
nodejs.nw.MenuItemType.Normal = "normal";
nodejs.peerjs.WRTCServerEventType.Connection = "connection";
nodejs.peerjs.WRTCServerEventType.Disconnect = "disconnect";
nodejs.stream.WritableEventType.Drain = "drain";
nodejs.stream.WritableEventType.Finish = "finish";
nodejs.stream.WritableEventType.Pipe = "pipe";
nodejs.stream.WritableEventType.Unpipe = "unpipe";
nodejs.stream.WritableEventType.Error = "error";
nodejs.tls.CleartextStreamEventType.SecureConnect = "secureConnect";
nodejs.tls.SecurePairEventType.Secure = "secure";
Main.main();
})();
