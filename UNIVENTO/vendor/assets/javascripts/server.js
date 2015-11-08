'use strict';

// Importing express and body parser libraries
var express = require('express');
var bodyParser = require('body-parser');

//this is a built in node library that handles the file system
var fs = require('fs');


/**
* Server configs
*/

/**
* The port to run your node server on
* 
* If you're running this on a web server this should be 80
* If you're running this locally try 8080 or 9080
*/
var BASE_PORT = 8080;

/** 
* The root directory of your files
*
* By default it uses the current folder this file is in
*/
var ROOT_DIR = __dirname + '/';
ROOT_DIR = fs.realpathSync(ROOT_DIR);
if (!fs.existsSync(ROOT_DIR)) {
	console.log('Error: cannot find working directory: ' + ROOT_DIR);
	exit();
}

/**
* Create an instance of express
*/
var app = express();

/**
 * Adds a simple logging, "mounted" on the root path.
 * Using Express middleware
 **/
app.use(function(req, res, next) {
	console.log('%s %s', req.method, req.url);
	next();
});

/**
 * Allows us to parse http body parameters as json
 **/
app.use(bodyParser.json());

app.use(express.static(ROOT_DIR));

app.listen(BASE_PORT, function() {
	console.log('Node server started @ http://localhost:' + BASE_PORT);
	console.log('Serving static files from ' + ROOT_DIR);
	console.log('Press Ctrl + c for server termination');
});