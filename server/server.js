"use strict";

var _ = require('lodash');
var express = require('express');
var app = express();
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var Promises = require('best-promise');
var fs = require('fs-promise');
var path = require('path');
var pg = require('pg-promise-strict');
var readYaml = require('read-yaml-promise');
var extensionServeStatic = require('extension-serve-static');
var jade = require('jade');
// var passport = require('passport');
// var ensureLoggedIn = require('connect-ensure-login').ensureLoggedIn;
// var LocalStrategy = require('passport-local').Strategy;
// var crypto = require('crypto');

app.use(cookieParser());
app.use(bodyParser.urlencoded({extended:true}));

function serveJade(pathToFile,anyFile){
    return function(req,res,next){
        if(path.extname(req.path)){
            console.log('req.path',req.path);
            return next();
        }
        Promise.resolve().then(function(){
            var fileName=pathToFile+(anyFile?req.path+'.jade':'');
            return fs.readFile(fileName, {encoding: 'utf8'})
        }).catch(function(err){
            if(anyFile && err.code==='ENOENT'){
                throw new Error('next');
            }
            throw err;
        }).then(function(fileContent){
            var htmlText=jade.render(fileContent);
            serveHtmlText(htmlText)(req,res);
        }).catch(serveErr(req,res,next));
    }
}

// probar con http://localhost:12348/ajax-example
app.use('/',serveJade('client',true));

function serveHtmlText(htmlText){
    return function(req,res){
        res.setHeader('Content-Type', 'text/html; charset=utf-8');
        res.setHeader('Content-Length', htmlText.length);
        res.end(htmlText);
    }
}

function serveErr(req,res,next){
    return function(err){
        if(err.message=='next'){
            return next();
        }
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

var actualConfig;

var clientDb;

Promises.start(function(){
    return readYaml('global-config.yaml',{encoding: 'utf8'});
}).then(function(globalConfig){
    actualConfig=globalConfig;
    return readYaml('local-config.yaml',{encoding: 'utf8'}).catch(function(err){
        if(err.code!=='ENOENT') throw err;
        return {};
    }).then(function(localConfig){
        _.merge(actualConfig,localConfig);
    });
}).then(function(){
    return new Promise(function(resolve, reject){
        var server=app.listen(actualConfig.server.port, function(event) {
            console.log('Listening on port %d', server.address().port);
            resolve();
        });
    });
}).then(function(){
    return pg.connect(actualConfig.db);
}).then(function(client){
    console.log("CONECTED TO", actualConfig.db.database);
    clientDb=client;
    /*
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
    */
}).then(function(){
    app.use('/ejemplo/suma',function(req,res){
        if(req.method==='POST'){
            var params=req.body;
        }else{
            var params=req.query;
        }
        // probar con localhost:12348/ejemplo/suma?alfa=3&beta=7
        clientDb.query('select $1::integer + $2::integer as suma',[params.alfa||1,params.beta||10]).fetchUniqueRow().then(function(result){
            if(req.method==='POST'){
                res.send(''+result.rows[0].suma);
            }else{
                res.send('<h1>la suma es '+result.rows[0].suma+'<h1>');
            }
        }).catch(function(err){
            console.log('err ejemplo/suma',err);
            throw err;
        }).catch(serveErr);
    });
    app.get('/persona/load',function(req,res){
        var params=req.query;
        // probar con localhost:12348/ejemplo/resta?alfa=19&beta=7
        clientDb.query('select * from reqper.personas where dni = $1',[params.dni]).fetchOneRowIfExists().then(function(result){
            res.send(JSON.stringify(result.row));
        }).catch(function(err){
            console.log('err ejemplo/load',err);
            
            throw err;
        }).catch(serveErr);
    });
    app.get('/persona/siguiente',function(req,res){
        var params=req.query;
        // probar con localhost:12348/ejemplo/resta?alfa=19&beta=7
        clientDb.query('select * from reqper.personas where dni = $1',[params.dni]).fetchOneRowIfExists().then(function(result){
            res.send(JSON.stringify(result.row));
        }).catch(function(err){
            console.log('err ejemplo/siguiente',err);
            
            throw err;
        }).catch(serveErr);
    });    
    app.get('/persona/anterior',function(req,res){
        var params=req.query;
        // probar con localhost:12348/ejemplo/resta?alfa=19&beta=7
        clientDb.query('select * from reqper.personas where dni = $1',[params.dni]).fetchOneRowIfExists().then(function(result){
            res.send(JSON.stringify(result.row));
        }).catch(function(err){
            console.log('err ejemplo/anterior',err);
            
            throw err;
        }).catch(serveErr);
    });    
    app.get('/persona/primero',function(req,res){
        var params=req.query;
        // probar con localhost:12348/ejemplo/resta?alfa=19&beta=7
        clientDb.query('select * from reqper.personas where dni = $1',[params.dni]).fetchOneRowIfExists().then(function(result){
            res.send(JSON.stringify(result.row));
        }).catch(function(err){
            console.log('err ejemplo/primero',err);
            
            throw err;
        }).catch(serveErr);
    });    
    app.get('/persona/ultimo',function(req,res){
        var params=req.query;
        // probar con localhost:12348/ejemplo/resta?alfa=19&beta=7
        clientDb.query('select * from reqper.personas where dni = $1',[params.dni]).fetchOneRowIfExists().then(function(result){
            res.send(JSON.stringify(result.row));
        }).catch(function(err){
            console.log('err ejemplo/ultimo',err);
            
            throw err;
        }).catch(serveErr);
    });
    app.get('/persona/grabar',function(req,res){
        var params=req.query;
        // probar con localhost:12348/ejemplo/resta?alfa=19&beta=7
        clientDb.query('select * from reqper.personas where dni = $1',[params.dni]).fetchOneRowIfExists().then(function(result){
            res.send(JSON.stringify(result.row));
        }).catch(function(err){
            console.log('err ejemplo/grabar',err);
            
            throw err;
        }).catch(serveErr);
    });     
}).catch(function(err){
    console.log('ERROR',err);
    console.log('STACK',err.stack);
    console.log('las partes que dependen de la base de datos no fueron instaladas en su totalidad');
    console.log('***************');
    console.log('REVISE QUE EXISTA LA DB');
});
