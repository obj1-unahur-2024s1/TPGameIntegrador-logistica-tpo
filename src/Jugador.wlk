import Game.*
import wollok.game.*



object jugador{
	var property combust = 1000
	const property image = "Assets/Jugador.png"
	var property position = game.at(6,0)


	method moverDerecha(){
		const nuevaPosD = 10.min(position.x() + 2)
		position = game.at(nuevaPosD, position.y())
	
	}
	method moverIzquierda(){
		const nuevaPosI = 2.max(position.x() - 2)
		position = game.at(nuevaPosI, position.y())
	}
	

	method andar(){
		combust = combust - 20
	}
	method gastarC(){
		game.onTick(1000,"g",{self.andar()})
	}

}

////////////// a partir de acá los poderes //////////////



object poderCombust{
	
	method activar(){
		jugador.combust(1000)
		game.say(jugador, "¡¡Combustible cargado!!")
	}
	
}

object poderPuntos{

	method activar(){
		const sumarPuntos = reloj.tiempo() + 400
		reloj.tiempo(sumarPuntos)
		game.say(jugador, "¡¡Estoy mas cerca de la meta!!")
	}
}
