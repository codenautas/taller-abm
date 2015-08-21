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
            traerx:function(){
                vm.parametros.estado="loading";
                setTimeout(function(){
                    vm.parametros.estado="ok";
                    vm.datos.nombre='Estefi';
                    $scope.$apply();
                },100);
            },
            traer:function(){
                vm.parametros.estado="loading";
                AjaxBestPromise.get({
                    url:'/persona/load',
                    data:{dni: vm.parametros.dni}
                }).then(function(result){
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
    
})();