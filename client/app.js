"use strict";

(function (){

    var app = angular.module("personasApp",[]);
    
    app.controller("PersonasCtrl",function($scope){
        var vm=this;
        vm.vacio=true;
        vm.parametros={};
        vm.parametros.estado="vacio";
        vm.parametros.dni=71184210;
        vm.datos={};
        vm.infoCampos={
            dni:{ tipoVisual:'dni' },
            seleccionado:{ tipoVisual:'check' },
            cod_niv_estud:{ tipoVisual:'numerico' },
        };
        vm.operaciones={
            traer:function(operacion){
                var operaciones={
                    load:     { conDni:true },
                    anterior: { conDni:true },
                    siguiente:{ conDni:true },
                }
                vm.parametros.estado="loading";
                var parametrosLlamada={
                    url:'/persona/' + operacion,
                    data:{}
                }
                if((operaciones[operacion]||{}).conDni){
                    parametrosLlamada.data.dni = vm.parametros.dni;
                }
                AjaxBestPromise.get(parametrosLlamada).then(function(result){
                    vm.parametros.estado="ok";
                    vm.datos=JSON.parse(result);
                    vm.campos=Object.keys(vm.datos);
                }).catch(function(err){
                    vm.parametros.estado="error";
                    vm.parametros.mensaje_error=err.message;
                }).then(function(){
                    $scope.$apply();
                });
            }
            /*traer:function(){
                vm.parametros.estado="loading";
                
                AjaxBestPromise.get({
                    url:'/persona/load',
                    data:{dni: vm.parametros.dni}
                }).then(
                    function(result){
                    vm.parametros.estado="ok";
                    vm.datos=JSON.parse(result);
                    vm.campos=Object.keys(vm.datos);
                }).catch(function(err){
                    vm.parametros.estado="error";
                    vm.parametros.mensaje_error=err.message;
                }).then(function(){
                    $scope.$apply();
                });
            }*/
        }
    });

    
    app.controller("ErroresCtrl",function(){
        var vm=this;
        vm.message="";
        vm.object="";
        window.addEventListener('error', function(err){
            vm.message=err.message;
            vm.object=JSON.stringify(err);
        });
    });
    /*function consulta(operacion){
        vm.parametros.estado="loading";
        AjaxBestPromise.get({
            url:'/persona/'+operacion,
            data:{dni: vm.parametros.dni}
        }).then(
            function(result){
            vm.parametros.estado="ok";
            vm.datos=JSON.parse(result);
            vm.campos=Object.keys(vm.datos);
        }).catch(function(err){
            vm.parametros.estado="error";
            vm.parametros.mensaje_error=err.message;
        }).then(function(){
            $scope.$apply();
        });
    }*/
})();