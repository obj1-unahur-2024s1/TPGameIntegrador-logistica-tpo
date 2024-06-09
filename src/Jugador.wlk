import Game.*
import wollok.game.*



object jugador{
	const property baul = []
	var property combust = 1000
	var property image = "Assets/Jugador.png"
	var property position = game.at(12,0)
	const property poderes = [new PoderCombust() , new PoderPuntos()]
	
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
			baul.first().activar() // Es necesario el first si solo va a haber uno?
			baul.clear() // Una vez se activa el poder, se elimina, no me acordaba como era el eliminar uno solo, así que puse clear
		}
	}
	
	method agregarPoder(){
		self.baul().add(poderes.anyOne())
	}
	
//	method disparar(){
//		const proyectil = new Proyectil(position = self.position().up(1))
//		proyectil.avanzar()
//	}

}
////////////// a partir de acá los poderes //////////////

class Poderes{
	
	method activar()
	
}


class PoderCombust inherits Poderes{
	override method activar(){
		jugador.combust(1000)
	}
}

class PoderPuntos inherits Poderes{
	override method activar(){
		const sumarPuntos = reloj.tiempo() + 1000
		reloj.tiempo(sumarPuntos)
	}
}

// Por si hacemos el poder del proyectil

//class PoderProyectil inherits Poderes{
//	
//	const property image = "Assets/proyectil.png"
//	
//	var property position 
//	
//
//	override method activar(){
//		jugador.disparar()
//	}
//	
//	method hacerRecorrido(){
//		
//		game.addVisual(self)
//		game.onCollideDo(self,{elem => elem.serImpactado()})
//		game.onTick(500,"avanzar",{self.avanzar()})
//	}
//	method avanzar(){
//		position = position.up(32)
//		}
//
//	
//	method detener(){
//		game.removeTickEvent("avanzar")
//		game.removeVisual(self)
//	}
//}