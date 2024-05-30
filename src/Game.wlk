import wollok.game.*

object juego{
	method iniciar(){
		game.cellSize(32) // Mejor tamaño para conseguir assets (imagenes)
		game.width(40) // Resolución 1280 (40*32)
		game.height(27) // Resolución 864 (Es un poco mas grande que 720)
		game.title("Road Race Powered") // Nombre temporal
		game.addVisual(fondo)
		game.addVisual(jugador)
		game.start()
	}
}

/*
 A excepción del jugador y enemigos, todos estos Assets son placeholders, es decir, los usamos como ejemplo para ver que funcionen
 Cuando Victor tenga listo los finales me encargo de reemplazarlos
 */

object jugador{
	method image() = "Assets/Jugador.png"
	method position() = game.at(12,0)
}

object fondo{
	method image() = "Assets/FondoNivel1.jpg"
	method position() = game.origin()
}