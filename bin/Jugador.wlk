import Game.*
import wollok.game.*



object jugador{
	const property baul = []
	var property combust = 1000
	const property image = "Assets/Jugador.png"
	var property position = game.at(6,0)
	const property poderes = [new PoderCombust() , new PoderPuntos(), new PoderProyectil()]
	
	method agarrar(cosa){
		if(baul == [ ]) baul.add(cosa)
	}
	
	method moverDerecha(){
		const nuevaPosD = 10.min(position.x() + 2)
		position = game.at(nuevaPosD, position.y())
	
	}
	method moverIzquierda(){
		const nuevaPosI = 2.max(position.x() - 2)
		position = game.at(nuevaPosI, position.y())
	}


	method activarPoder(){
		if (baul.isEmpty()){
			game.say(self,"No tengo poderes disponibles")
		}else{
			const poder = baul.first()
			poder.activar()
			baul.clear()
		}
	}
	
	method agregarPoder(){
		self.baul().add(poderes.anyOne())
	}
	
	method andar(){
		game.onTick(1000,"andar",{combust = combust - 1})
	}
}

////////////// a partir de acá los poderes //////////////

class Poderes{ // No debería heredar de el objeto obtener poder, 

	method activar()
	
}


class PoderCombust inherits Poderes{
	const property position = game.at(14,5)
	override method activar(){
		jugador.combust(1000)
		game.say(jugador, "¡¡Combustible cargado!!")
	}
	
}

class PoderPuntos inherits Poderes{
	const property image = "Assets/poderPuntos.png"
	const property position = game.at(14,5)
	override method activar(){
		const sumarPuntos = reloj.tiempo() + 1000
		reloj.tiempo(sumarPuntos)
		game.say(jugador, "¡¡Consegui varios puntos!!")
	}
}


class PoderProyectil inherits Poderes{
	var position = jugador.position().up(1) 
	var image = "Assets/Proyectil.png"
	
	
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