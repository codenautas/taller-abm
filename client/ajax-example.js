"use strict";

function eid(x){
    return document.getElementById(x);
}

var AjaxBestPromise={};

AjaxBestPromise.createMethodFunction=function(method){
    return function(params){
        return new Promise(function(resolve,reject){
            var ajax = new XMLHttpRequest();
            if(!method){
                return reject(new Error('debe indicar el method en ajax'));
            }
            ajax.onload=function(e){
                if(ajax.status!=200){
                    reject(new Error(ajax.status+' '+ajax.responseText));
                }else{
                    resolve(ajax.responseText);
                }
            }
            ajax.onerror=reject;
            var paqueteAEnviar=Object.keys(params.data).map(function(key){
                return key+'='+encodeURIComponent(params.data[key]);
            }).join('&');
            if(method==='POST'){
                ajax.open(method,params.url);
                ajax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
                ajax.send(paqueteAEnviar);
            }else{
                var url=params.url+(paqueteAEnviar?'?'+paqueteAEnviar:'');
                ajax.open(method,url);
                ajax.send();
            }
        });
    }
}

AjaxBestPromise.post=AjaxBestPromise.createMethodFunction('POST');
AjaxBestPromise.get=AjaxBestPromise.createMethodFunction('GET');

window.addEventListener('load',function(){
    eid('status').textContent='listo para empezar';
    eid('get').onclick=function(){
        AjaxBestPromise.get({
            url:'/ejemplo/suma',
            data:{alfa:eid('alfa').value, beta:eid('beta').value},
        }).then(function(resultado){
            eid('resultado').textContent=resultado;
        }).catch(function(error){
            eid('status').textContent=''+error;
        });
    }
    eid('post').onclick=function(){
        AjaxBestPromise.post({
            url:'/ejemplo/suma',
            data:{alfa:eid('alfa').value, beta:eid('beta').value},
        }).then(function(resultado){
            eid('resultado').textContent=resultado;
        }).catch(function(error){
            eid('status').textContent=''+error;
        });
    }
});