import wollok.game.*

object juego{
	method iniciar(){
		game.cellSize(32) // Mejor tamaño para conseguir assets (imagenes)
		game.width(40) // Resolución 1280 (40*32)
		game.height(27) // Resolución 864 (Es un poco mas grande que 720)
		game.title("Road Race Powered") // Nombre temporal
		game.addVisual(fondo)
		game.addVisual(jugador)
		game.addVisual(new Grieta(cantCombustibleDisminuido=jugador.combust()*0.7))
        game.addVisual(new AutoEnemigo(cantCombustibleDisminuido=jugador.combust()*0))
        game.addVisual(new ManchaDeCombustible(cantCombustibleDisminuido=jugador.combust()*0.7))
		reloj.iniciar()
		game.start()
	}
}

/*
 A excepción del jugador y enemigos, todos estos Assets son placeholders, es decir, los usamos como ejemplo para ver que funcionen
 Cuando Victor tenga listo los finales me encargo de reemplazarlos
 */

object jugador{
	const baul = []
	var property combust = 1000
	var property image = "Assets/Jugador.png"
	var property position = game.at(12,5)
	method agarrar(cosa){
		baul.add(cosa)
	}
}

object fondo{
	method image() = "Assets/FondoNivel1.jpg"
	method position() = game.origin()
}

 /* A excepción del jugador y enemigos, todos estos Assets son placeholders, es decir, los usamos como ejemplo para ver que funcionen
 Cuando Victor tenga listo los finales me encargo de reemplazarlos
 */
 
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

object fondo1 {
	var property image = "Assets/PantallaDeInicio.jpg"
	var property position = game.at(5,8)
}
object fondo2 {
	var property image = "Assets/SeleccionDeNivel.jpg"
	var property position = game.at(5,8)
}

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
object reloj {
	
	var tiempo = 0
	
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
