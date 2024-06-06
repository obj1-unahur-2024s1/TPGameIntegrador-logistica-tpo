import wollok.game.*
import Jugador.*

object juego{
	method iniciar(){
		self.graficosBase()
		self.controlesJugador()
        self.obstaculos()
		self.graficosIndicadores()
		
		game.start()
	}
	
	method graficosBase(){
		game.cellSize(64) // Lo cambie a 64 para trabajar con assets mas grandes y que no haya error con el auto, puede que necesitemos todavía MAS grande
		game.width(20) // Resolución 1280 (40*32) |||| Nueva (20*64)
		game.height(13.5) // Resolución 864 (Es un poco mas grande que 720)
		game.title("Road Race Powered") // Nombre temporal
		game.boardGround("Assets/FondoNivel0.jpg")
		
	}
	
	method controlesJugador(){
		game.addVisualCharacter(jugador) // El character es temporal, para probar colisiones
        keyboard.right().onPressDo({jugador.moverDerecha()})
		keyboard.left().onPressDo({jugador.moverIzquierda()})
		
		//interaccion con poderes//
		keyboard.z().onPressDo({jugador.activarPoder()})
		// Colisiones
		game.whenCollideDo(jugador,{elem => elem.chocar() })
	}
	
	method obstaculos(){
		// Probé mil cosas y no se que poner acá, me sale error de overflow en TODO

	}

	
	method graficosIndicadores(){
		game.addVisual(indicadorCombus)
		game.addVisual(reloj)
		reloj.iniciar()
	}
}




 
///////// Cosas con la que el jugador puede chocar //////////////
class Obstaculos {
	
	const property listaPosiciones= [game.at(8,5), game.at(9,8), game.at(8,10) ] // Las posiciones no son definitivas, está hecho para que aparezcan
																				// siempre en pantalla, cuando funcione el movimiento lo arreglo
	
	var property position = listaPosiciones.anyOne()
	
	const property listaEnem = [new AutoEnemigo(), new ManchaDeCombustible(), new Grieta(), new ObjetoObtenerPoder()]
	
	
//	Se supone que esto sirve para crear un nuevo obstaculo y moverlo, pero me da error, lo dejo por si les sirve de algo
//
//	method hacerRecorrido(){
//		const nuevoEnem = listaEnem.anyOne() Guardo un enemigo al azar de la lista en una const
//		game.onTick(4000,"agregarObs",{game.addVisual(nuevoEnem)}) cada 4 segundos se debería agregar uno
//		game.onTick(4500,"moverObs",{nuevoEnem.desplazarse()}) cada 4,5 segundos se debería desplazar y al llegar a y = -1 o mas irse
//	}
//	
//		
//	
//	method desplazarse(){
//		position = position.down(3)
//		if(position.y() <= -1) game.removeVisual(self)
//	}
//	
	
	method chocar(){
		game.removeVisual(self)
	}


}




class AutoEnemigo inherits Obstaculos{

	var property image = "Assets/enemRojo.png"
	
	override method chocar(){
		game.stop()
		super()
	}
	
	method serImpactado(){ //Por si hacemos lo del proyectil
		game.removeVisual(self)
	}

	
}

class Grieta inherits Obstaculos{

	var property image = "Assets/Grieta.png"
	
	const property combustDism = 350
	override method chocar(){
		jugador.combust(jugador.combust() - combustDism)
		super()

	}
}

class ManchaDeCombustible inherits Obstaculos{

	var property image = "Assets/falta imagen"
	
	const property combustDism = 200
	
	override method chocar(){
		jugador.combust(jugador.combust() - combustDism)
		super()
	}
}

class ObjetoObtenerPoder inherits Obstaculos{

	
	const property image = "Assets/ObtenerPoder.png"


	
	override method chocar(){
		if (jugador.baul() == [ ]) jugador.agregarPoder() else game.say(jugador,"Solo puedo tener un poder a la vez")
		super()
	}
}


/////////////////////////////////////////////////////////////////////////////




//////////// Zona de Indicadores ////////////////

object indicadorCombus{
	
	const property position = game.at(16,3)
	var property image = if(jugador.combust().between(700,1000)) "Assets/bidonVerde.png"
						 else if(jugador.combust().between(400,699)) "Assets/bidonAmarillo.png"
						 else "Assets/bidonRojo.png"
	}



object reloj {
	var property tiempo = 0
	const property position = game.at(30,5)
	method text() = tiempo.toString()
	
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

object fondo1 {
	var property image = "Assets/PantallaDeInicio.jpg"
	var property position = game.center()
}
object fondo2 {
	var property image = "Assets/SeleccionDeNivel.jpg"
	var property position = game.center()
}


Imagenes de seleccion de fondo, por ahora no hacen falta hasta que se agregue la funcion de elegir nivel




--------------------------------------------------------------------------------------------------------------------
class poderes{

	const poderes = [new PoderCombust() , new PoderPuntos() ]
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

Esto lo hizo Brenda, lo guardo acá por las dudas, ya que intento separar la lista de poderes, del objeto que los da


---------------------------------------------------------------------------------------------------------------------------



Notas:
* 
* Quizá deberíamos aumentar el tamaño de las casillas a 64 o mas, ya que al tener 32, y el auto al tener una altura de 64
* la colision no se activa hasta que la mitad del auto choca
*
* preguntar por que no se puede restar normalmente los method chocar() 
* 
* Las colisones por ahora funcionan todas
* 



*/