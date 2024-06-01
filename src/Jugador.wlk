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
	
	method moverDerecha() {
		const nuevaPosD = 21.min(position.x() + 1)
		position = game.at(nuevaPosD, position.y())
	
	}
	method moverIzquierda() {
		const nuevaPosI = 3.max(position.x() - 1)
		position = game.at(nuevaPosI, position.y())
	}
	
	
}
////////////// a partir de acá los poderes //////////////

//class poderes{
//	const listaPoderes = [poderCombus, poderPuntos]
//	}
//}

object poderCombust{
	method activar(){
		jugador.combust() == 1000
	}
}

object poderPuntos{
	method activar(){
		reloj.tiempo() == reloj.tiempo() + 1000
	}
}