import Game.*
import wollok.game.*



object jugador{
	const property baul = []
	var property combust = 1000
	const property image = "Assets/Jugador.png"
	var property position = game.at(12,0)
	const property poderes = [new PoderCombust() , new PoderPuntos(), new PoderProyectil()]
	
	method agarrar(cosa){
		if(baul == [ ]) baul.add(cosa)
	}
	
	method moverDerecha(){
		const nuevaPosD = 0.min(position.x() + 1)
		position = game.at(nuevaPosD, position.y())
	
	}
	method moverIzquierda(){
		const nuevaPosI = 0.max(position.x() - 1)
		position = game.at(nuevaPosI, position.y())
	}

	//Interaccion con los poderes//
	method activarPoder(){
		if (baul.isEmpty()){
			game.say(self,"No tengo poderes disponibles")
		}else{
			const poder = baul.first()
			poder.activar() // Es necesario el first si solo va a haber uno?
			baul.clear() // Una vez se activa el poder, se elimina, no me acordaba como era el eliminar uno solo, así que puse clear
		}
	}
	
	method agregarPoder(){
		self.baul().add(poderes.anyOne())
	}
}
////////////// a partir de acá los poderes //////////////

class Poderes inherits ObjetoObtenerPoder{

	method activar()
	
}


class PoderCombust inherits Poderes{
	override method activar(){
		jugador.combust(1000)
		game.say(jugador, "¡¡Combustible cargado!!")
	}
}

class PoderPuntos inherits Poderes{
	override method activar(){
		const sumarPuntos = reloj.tiempo() + 1000
		reloj.tiempo(sumarPuntos)
		game.say(jugador, "¡¡Consegui varios puntos!!")
	}
}


class PoderProyectil inherits Poderes{
	
	override method imagen() = "Assets/Proyectil.png"
	
	override method posicion() = jugador.position().up(1) 
	// La posicion del proyectil siempre es donde aparece el jugador.

	
	override method activar(){
		game.addVisual(self)
		game.onCollideDo(self,{elem => 
			elem.serImpactado()
			self.detener()
		})
		game.onTick(500,"avanzar",{self.avanzar()})
	}	
	
	method avanzar(){
		const posNueva = position.up(1)
		position = posNueva
	}
		
	method detener(){
		game.removeTickEvent("avanzar")
		game.removeVisual(self)	
	}
}



