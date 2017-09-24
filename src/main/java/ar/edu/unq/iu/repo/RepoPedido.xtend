package ar.edu.unq.iu.repo

import org.uqbar.commons.model.CollectionBasedRepo
import ar.edu.unq.iu.modelo.Pedido

class RepoPedido extends CollectionBasedRepo<Pedido>{
	
	
	
	override protected getCriterio(Pedido arg0) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override createExample() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getEntityType() {
		typeof(Pedido)
	}
	
	def getPedidosAbiertos() {
		var p = newArrayList
		for (o : objects){
			if (o.tieneEstadoAbierto()){
				p.add(o)
			}
		}
		p
	}
	
	def getPedidosCerrados() {
		var p = newArrayList
		for (o : objects){
			if (!o.tieneEstadoAbierto()){
				p.add(o)
			}
		}
		p
	}
	
}