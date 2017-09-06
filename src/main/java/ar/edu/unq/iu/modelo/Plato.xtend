package ar.edu.unq.iu.modelo

import java.util.ArrayList

class Plato {
	
	double precio
	
	Pizza pizza
	
	Object tama�o
	
	ArrayList<Ingrediente> ingrExtras
	
	new(Pizza p, Object tama�o, ArrayList<Ingrediente> extras) {
		this.pizza = p
		this.tama�o = tama�o
		this.ingrExtras = extras
		this.precio = this.calcularPrecio()
	}
	
	def calcularPrecio() {
		precio = pizza.getPrecioBase() * 1 //EL UNO REPRESENTA AL PRECIO DEL TAMA�O POR AHORA 
		for (i : ingrExtras) {
			precio += i.getPrecio()
		}
		precio
	}
	
	def getPrecio() {
		this.precio
	}
	
}