"use strict";

var _ = require('lodash');
var express = require('express');
var app = express();
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var Promise = require('best-promise');
var fs = require('fs-promise');
var path = require('path');
var pg = require('pg-promise-strict');
var readYaml = require('read-yaml-promise');
var extensionServeStatic = require('extension-serve-static');
// var jade = require('jade');
// var passport = require('passport');
// var ensureLoggedIn = require('connect-ensure-login').ensureLoggedIn;
// var LocalStrategy = require('passport-local').Strategy;
// var crypto = require('crypto');

app.use(cookieParser());
app.use(bodyParser.urlencoded({extended:true}));


function serveHtmlText(htmlText){
    return function(req,res){
        res.setHeader('Content-Type', 'text/html; charset=utf-8');
        res.setHeader('Content-Length', htmlText.length);
        res.end(htmlText);
    }
}

function serveErr(req,res){
    return function(err){
        console.log('ERROR', err);
        console.log('STACK', err.stack);
        var text='ERROR! '+(err.code||'')+'\n'+err.message+'\n------------------\n'+err.stack;
        res.writeHead(200, {
            'Content-Length': text.length,
            'Content-Type': 'text/plain; charset=utf-8'
        });
        res.end(text);
    }
}

var mime = extensionServeStatic.mime;

var validExts=[
    'html',
    'jpg','png','gif',
    'css','js','manifest'];

app.use('/',extensionServeStatic('./client', {
    index: ['index.html'], 
    extensions:[''], 
    staticExtensions:validExts
}))

readYaml('local-config.yaml',{encoding: 'utf8'}).then(function(localConfig){
    actualConfig=localConfig;
    return new Promise(function(resolve, reject){
        var server=app.listen(localConfig.server.port, function(event) {
            console.log('Listening on port %d', server.address().port);
            resolve();
        });
    });
}).then(function(){
    return pg.connect(actualConfig.db);
}).then(function(client){
    console.log("CONECTED TO", actualConfig.db.database);
    passport.use(new LocalStrategy(
        function(username, password, done) {
            console.log("TRYING TO CONNECT",username, password);
            client
                .query('SELECT * FROM inter.users WHERE username=$1 AND hashpass=$2',[username, md5(password+username.toLowerCase())])
                .fetchUniqueRow()
                .then(function(data){
                    console.log("LOGGED IN",data.row);
                    done(null, data.row);
                }).catch(logAndThrow).catch(done);
        }
    ));
}).catch(function(err){
    console.log('ERROR',err);
    console.log('STACK',err.stack);
    console.log('las partes que dependen de la base de datos no fueron instaladas en su totalidad');
});
