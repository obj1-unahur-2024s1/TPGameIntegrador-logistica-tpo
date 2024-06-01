import wollok.game.*
import Jugador.*

object juego{
	method iniciar(){
		
		// Tamaño del juego//
		game.cellSize(32) // Mejor tamaño para conseguir assets (imagenes)
		game.width(40) // Resolución 1280 (40*32)
		game.height(27) // Resolución 864 (Es un poco mas grande que 720)
		game.title("Road Race Powered") // Nombre temporal
		// Tamaño del juego fin //

		// Jugador Inicio //
		game.addVisual(fondo)
		game.addVisual(jugador)
		self.controlesJugador()
		// Jugador Fin //
		
		
		game.addVisual(new Grieta(cantCombustibleDisminuido=jugador.combust()*0.7))
        game.addVisual(new AutoEnemigo(cantCombustibleDisminuido=jugador.combust()*0))
        game.addVisual(new ManchaDeCombustible(cantCombustibleDisminuido=jugador.combust()*0.7))
        
      
		
		// Zona de indicadores Inicio//
		
		game.addVisual(indicadorCombus) // NO SE AÑADE AAAAAAAAAAAAAAAAAAAAAAAAAAA
		reloj.iniciar()
		
		// Zona de indicadores Fin//
		
		game.start()
	}
	
	method controlesJugador(){
        keyboard.right().onPressDo({jugador.moverDerecha()})
		keyboard.left().onPressDo({jugador.moverIzquierda()})
	}

}


object fondo{
	method image() = "Assets/FondoNivel0.jpg"
	method position() = game.origin()
}
 
class Obstaculos {
	var  property cantCombustibleDisminuido
	
	
	/*method posicionInicial() = game.at(3,23)
	method iniciar(){
		const velocidad = 0
		position = self.posicionInicial()
		game.onTick(velocidad,"moverEnemigos",{self.mover()})
	}
	method mover(){
		position = position.down(1)
		if (position.y() == -1)
			position = self.posicionInicial()
	}
			*/
}



///////// Cosas con la que el jugador puede chocar //////////////

class Grieta inherits Obstaculos{
	var property position = self.posicionInicial()
	var property image = "Assets/Grieta.png"
	method posicionInicial() = game.at(3,15)
	method iniciar(){
		const velocidad = 0
		position = self.posicionInicial()
		game.onTick(velocidad,"moverEnemigos",{self.mover()})
	}
	method mover(){
		position = position.down(1)
		if (position.y() == -1)
			position = self.posicionInicial()
	}
}
class AutoEnemigo inherits Obstaculos{
	var property position = self.posicionInicial()
	var property image = "Assets/enemRojo.png"
	method posicionInicial() = game.at(3,23)
	method iniciar(){
		const velocidad = 0
		position = self.posicionInicial()
		game.onTick(velocidad,"moverEnemigos",{self.mover()})
	}
	method mover(){
		position = position.down(1)
		if (position.y() == -1)
			position = self.posicionInicial()
	}
}
class ManchaDeCombustible inherits Obstaculos{
	var property position = self.posicionInicial()
	method posicionInicial() = game.at(3,23)
	method iniciar(){
		const velocidad = 0
		position = self.posicionInicial()
		game.onTick(velocidad,"moverEnemigos",{self.mover()})
	}
		method mover(){
		position = position.down(1)
		if (position.y() == -1)
			position = self.posicionInicial()
	}
}
/////////////////////////////////////////////////////////////////////////////


object fondo1 {
	var property image = "Assets/PantallaDeInicio.jpg"
	var property position = game.at(5,8)
}
object fondo2 {
	var property image = "Assets/SeleccionDeNivel.jpg"
	var property position = game.at(5,8)
}



//////////// Zona de Indicadores ////////////////

object indicadorCombus{
	
	const property position = game.at(30,3)
	var property image = if(jugador.combust().between(700,1000)) "Assets/bidonVerde.png"
						 else if(jugador.combust().between(400,699)) "Assets/bidonAmarillo.png"
						 else "Assets/bidonRojo.png"
	}



object reloj {
	
	var property tiempo = 0
	
	method text() = tiempo.toString()
	method position() = game.at(21, 28)
	
	method pasarTiempo() {
		tiempo = tiempo +1
	}
	method iniciar(){
		tiempo = 0
		game.onTick(100,"tiempo",{self.pasarTiempo()})
	}
	method detener(){
		game.removeTickEvent("tiempo")
	}
}


/*
////////////// Pensar si dejar o quitar ////////////

object bidonVerde {
	const property image = "Assets/bidonVerde.png"
	const property position = game.at(21,3)
}
object bidonRojo {
	const property image = "Assets/bidonRojo.png"
	const property  position = game.at(25,3)
}
object bidonAmarillo {
	const property image = "Assets/bidonAmarillo.png"
	const property position = game.at(23,3)
}

Esto no se si vale la pena, el object indicadorCombus ya se encarga de añadir todo llamando a las imagenes
Podemos llamarlo con los objetos, pero no se si vale la pena

*/