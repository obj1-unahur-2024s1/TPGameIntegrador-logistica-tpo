import Game.*
import wollok.game.*



object jugador{
	const baul = []
	var property combust = 1000
	var property image = "Assets/Jugador.png"
	var property position = game.at(12,0)
	
	method agarrar(cosa){
		if(baul == [ ]) baul.add(cosa)
	}
	
	method moverDerecha(){
		const nuevaPosD = 21.min(position.x() + 1)
		position = game.at(nuevaPosD, position.y())
	
	}
	method moverIzquierda(){
		const nuevaPosI = 3.max(position.x() - 1)
		position = game.at(nuevaPosI, position.y())
	}
	//Interaccion con los poderes//
	method activarPoder(){
		if (baul.isEmpty()){
			game.say(self,"No tengo poderes disponibles")
		}else{
			baul.first().activar()
		}
	}
}
////////////// a partir de acá los poderes //////////////

class Poderes{
	var property position = self.posicionInicial()
	var property image = "Assets/ObtenerPoder.png"
	method posicionInicial() = game.at(3,10)
	method iniciar(){
		const velocidad = 0
		game.onTick(velocidad,"moverPoderes",{self.mover()})
	}
	method mover(){
		position = position.down(1)
		if (position.y() == -1)
			position = self.posicionInicial()
	}
}

class PoderCombust inherits Poderes{
	method activar(){
		return jugador.combust(500)
	}
}

class PoderPuntos inherits Poderes{
	override method posicionInicial() = game.at(3,20)
	method activar(){
		reloj.tiempo(1000)
	}
}