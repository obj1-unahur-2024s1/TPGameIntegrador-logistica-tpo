import Game.*
import wollok.game.*



object jugador{
	const baul = []
	var property combust = 1000
	var property image = "Assets/Jugador.png"
	var property position = game.at(12,0)
	
	method agarrar(cosa){
		baul.add(cosa)
	}
	
	method moverDerecha() {
		const nuevaPosD = 21.min(position.x() + 1)
		position = game.at(nuevaPosD, position.y())
	
	}
	method moverIzquierda() {
		const nuevaPosI = 2.max(position.x() - 1)
		position = game.at(nuevaPosI, position.y())
	}
	
	
}
////////////// a partir de acá los poderes //////////////