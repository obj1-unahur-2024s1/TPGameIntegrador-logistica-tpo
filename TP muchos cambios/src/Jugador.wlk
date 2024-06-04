import Game.*
import wollok.game.*



object jugador{
	const property baul = []
	var property combust = 1000
	var property image = "Assets/Jugador.png"
	var property position = game.at(12,0)
	const property poderes = [new PoderCombust() , new PoderPuntos() ]
	
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
			baul.first().activar() // Es necesario el firts si solo va a haber uno?
			baul.clear() // Una vez se activa el poder, se elimina, no me acordaba como era el eliminar uno solo, así que puse clear
		}
	}
	
	method agregarPoder(){
		self.baul().add(poderes.anyOne())
	}
	

}
////////////// a partir de acá los poderes //////////////

class Poderes{
	
	method activar(){
		
	}
	
}


class PoderCombust inherits Poderes{
	override method activar(){
//		jugador.combust() = jugador.combust() + 1000 //No funcionaría?
		jugador.combust(1000)
	}
}

class PoderPuntos inherits Poderes{
	override method activar(){
//		reloj.tiempo() += 1000 Tampoco funciona
		reloj.tiempo(1000)
	}
}

