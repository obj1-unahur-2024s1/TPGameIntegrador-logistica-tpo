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
		game.cellSize(32) // Mejor tamaño para conseguir assets (imagenes)
		game.width(40) // Resolución 1280 (40*32)
		game.height(27) // Resolución 864 (Es un poco mas grande que 720)
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
		game.addVisual(new ObjetoObtenerPoder())							
		game.addVisual(new Grieta(cantCombustibleDisminuido=jugador.combust()*0.7))
        game.addVisual(new AutoEnemigo())
        game.addVisual(new ManchaDeCombustible(cantCombustibleDisminuido=jugador.combust()*0.7))
	}
	
	method graficosIndicadores(){
		game.addVisual(indicadorCombus)
		game.addVisual(reloj)
		reloj.iniciar()
	}
}




 
///////// Cosas con la que el jugador puede chocar //////////////
class Obstaculos {
	
	const property listaPosiciones= [game.at(41,3), game.at(41,5), game.at(41,8) ]
	
	var property position = listaPosiciones.anyOne()
	
	method movimiento(){
		game.onTick(1000,"moverObstaculos",{self.MoverObstaculo()})
	}
	
	method MoverObstaculo(){
		self.position().down(2)
	}
	
//	method iniciar(){
//		const velocidad = 0
//		const position = listaPosiciones.anyOne()
//		game.onTick(velocidad,"moverEnemigos",{self.mover()})
//	}
//	
//	method mover(){
//		
//		position = position.down(1)
//		if (position.y() == -1)
//			position = self.posicionInicial()
//	}
//
//			
	
	method chocar(){
		game.removeVisual(self)
	}
}




class AutoEnemigo inherits Obstaculos{
	
//	var property position = game.at(3,23)
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
	var  property cantCombustibleDisminuido =0
//	var property position = game.at(3,20)
	var property image = "Assets/Grieta.png"
	
	
	override method chocar(){
		jugador.combust(-300)
		super()

	}
}

class ManchaDeCombustible inherits Obstaculos{
	var  property cantCombustibleDisminuido
//	var property position = game.at(5,23)
	var property image = "Assets/fh"
	
	
	override method chocar(){
		jugador.combust(-200)
		super()
	}
}

class ObjetoObtenerPoder inherits Obstaculos{
	// Acá irían las cosas que al chocarlos, agregan un poder (Temporalmente las cosas rosas)
	
	const property image = "Assets/ObtenerPoder.png"
//	var property position = game.at(3,15)

	
	override method chocar(){
		if (jugador.baul() == [ ]) jugador.agregarPoder() else game.say(jugador,"Solo puedo tener un poder a la vez")
		super()
	}
}


/////////////////////////////////////////////////////////////////////////////




//////////// Zona de Indicadores ////////////////

object indicadorCombus{
	
	const property position = game.at(30,3)
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