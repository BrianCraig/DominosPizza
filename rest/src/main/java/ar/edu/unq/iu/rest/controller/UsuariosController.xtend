package ar.edu.unq.iu.rest.controller

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import ar.edu.unq.iu.appmodel.UsuariosAppModel
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.http.ContentType
import ar.edu.unq.iu.rest.modelo.Login
import ar.edu.unq.iu.rest.modelo.RequestError
import ar.edu.unq.iu.rest.modelo.BadRequestError
import ar.edu.unq.iu.rest.modelo.NuevoUsuario

@Controller
class UsuariosController {
	extension JSONUtils = new JSONUtils
	
	UsuariosAppModel appModel = new UsuariosAppModel()
	
	@Post("/ingreso")
	def ingresar(@Body String bodyConLogin) {
		try {
			val login = bodyConLogin.fromJson(Login)
			if(appModel.existeClienteCon(login.nick, login.password)){
				ok(appModel.clienteCon(login.nick, login.password).toJson)
			} else {
				badRequest(new RequestError("el nick y la clave no coinciden").toJson)
			}
		} catch (Exception e){
			badRequest(new BadRequestError().toJson)
		}
	}
	
	@Put("/usuarios/:id")
	def editar() {
		ok(null)
	}
	
	@Post("/usuarios") 
	def crear(@Body String bodyConUsuario) {
		val usuario = bodyConUsuario.fromJson(NuevoUsuario)
		try{
			if(!appModel.datosCorrectos(usuario.nombre, usuario.nick, usuario.password, usuario.mail, usuario.direccion)){
				ok(appModel.createCliente(usuario.nombre, usuario.nick, usuario.password, usuario.mail, usuario.direccion).toJson)
			} else {
				badRequest(new RequestError("Ocurrio un error durante el procesamiento de datos para la creacion de un usuario nuevo.").toJson)
			}
		} catch (Exception e){
			badRequest(new BadRequestError().toJson)
		}
	}
	
	@Get("/usuarios/:id/pedidos") 
	def leerPedido() {
		response.contentType = ContentType.APPLICATION_JSON
		try{
			if(!id.nullOrEmpty){
				ok(appModel.clienteConId(id).toJson) 
			} else {
				badRequest(new RequestError("Error al procesar el ID.").toJson)
			}
		} catch (Exception e) {
			badRequest(new BadRequestError().toJson)
		}
	}
}