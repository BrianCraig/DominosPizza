'use strict';

class SeleccionarPizzaController {
    constructor($state, UsuarioService, PizzasService, TamanioService, PedidoService, IngredienteService) {
        this.pizzasS = PizzasService;
        this.usuarioS = UsuarioService;
        this.tamanioS = TamanioService;
        this.pedidoS = PedidoService;
        this.ingredienteS = IngredienteService;
        this.$state = $state;
    }

    seleccionarPizza(unaPizza){
        this.pizzaSeleccionada = unaPizza;
        $('#seleccionarTamanio').modal('show')
    }

    seleccionarTamanio(unTamanio){
        this.platoSeleccionado = new Plato({
            pizza: this.pizzaSeleccionada,
            tamanio: unTamanio
        });
        $('#seleccionarTamanio').modal('hide').after(() =>{
            $('#verIngredientes').modal('show')
        })
    }

    confirmarPlato(){
        this.pedidoS.agregarPlato(this.platoSeleccionado);
        this.$state.go("cofirmarPedido")
    }

    seleccionarIngredientesExtras(){
        $('#seleccionarIngredientesExtras').modal('show')
    }

    seleccionarIngredienteAgregado(unIngrediente){
        this.extras = [];
        this.agregado = new Agregado({
            ingrediente: unIngrediente
        });
        this.extras.add(this.agregado)
    }

    agregarIngredientesExtra(){
        this.platoSeleccionado.agregados.add(this.extras);
        $('#seleccionarIngredientesExtras').modal('hide').then(
            () => this.$state.go("seleccionarPizza"))
    }

    agregarLadoAIngrediente(unIngrediente, unLado){
        this.extras.forEach(this.ladoAIngrediente(unIngrediente, unLado))
    }

    ladoAIngrediente(extra, unIngrediente, unLado){
        if (extra.ingrediente.nombre == unIngrediente.nombre) {
            extra.lado = unLado
        }
    }

    editarUsuario(){
        this.$state.go("editarUsuario")
    }
}

angular.module('dominosApp').component('seleccionarPizza', {
    templateUrl: '/app/seleccionarPizza/seleccionar-pizza.component.html',
    controller: SeleccionarPizzaController,
    controllerAs: "controller"
});