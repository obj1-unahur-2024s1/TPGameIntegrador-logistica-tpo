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
		game.addVisual(fondo)
		fondo.movimiento()
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

		const listaAparicion = [(2000),(4000),(300),(6000),(1000),(500),(900)]
		var autoER1 = new AutoEnemigo()
		var autoER2 = new AutoEnemigo()
		var autoER3 = new AutoEnemigo()
		var autoER4 = new AutoEnemigo()
		var autoA1 = new AutoEnemigoA()
		var autoA2 = new AutoEnemigoA()
		var autoV = new AutoEnemigoV()
		var autoV2 = new AutoEnemigoV()
		var autoV3 = new AutoEnemigoV()
		var camion1 = new Camion()
		var pod1 = new ObjetoObtenerPoder()
		var pod2 = new ObjetoObtenerPoder()
		var grieta1 = new Grieta()
		var grieta2 = new Grieta()
		var grieta3 = new Grieta()
		var comb = new CargaCombust()
		var comb2 = new CargaCombust()
		
		
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoER1)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoER2)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoER3)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoER4)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoA1)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoA2)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoV)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoV2)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoV3)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(camion1)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(comb)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(comb2)})
		game.schedule(10000,{game.addVisual(pod1)})
		game.schedule(45000, {game.addVisual(pod2)})
		game.schedule(listaAparicion.anyOne(), {game.addVisual(grieta1)})
		game.schedule(listaAparicion.anyOne(), {game.addVisual(grieta2)})
		game.schedule(listaAparicion.anyOne(), {game.addVisual(grieta3)})
		game.onTick(1000, "mov",{if(game.hasVisual(autoER1))autoER1.moverObstaculos()})
		game.onTick(1000, "mov", {if(game.hasVisual(autoER2))autoER2.moverObstaculos()}) 
		game.onTick(1000, "mov", {if(game.hasVisual(autoER3))autoER3.moverObstaculos()})
		game.onTick(1000, "mov", {if(game.hasVisual(autoER4))autoER4.moverObstaculos()})
		game.onTick(1000, "mov",{if(game.hasVisual(autoA1))autoA1.moverObstaculos()})
		game.onTick(1000, "mov",{if(game.hasVisual(autoA2))autoA2.moverObstaculos()})
		game.onTick(1000, "mov",{if(game.hasVisual(autoV))autoV.moverObstaculos()})
		game.onTick(1000, "mov",{if(game.hasVisual(autoV2))autoV2.moverObstaculos()})
		game.onTick(1000, "mov",{if(game.hasVisual(autoV3))autoV3.moverObstaculos()})
		game.onTick(800, "mov",{if(game.hasVisual(camion1))camion1.moverObstaculos()})
		game.onTick(1000, "mov",{if(game.hasVisual(comb))comb.moverObstaculos()})
		game.onTick(1000, "mov",{if(game.hasVisual(comb2))comb2.moverObstaculos()})
		game.onTick(1000, "mov", {if(game.hasVisual(pod1))pod1.moverObstaculos()})
		game.onTick(1000, "mov", {if(game.hasVisual(pod2))pod2.moverObstaculos()})
		game.onTick(1000, "mov", {if(game.hasVisual(grieta1))grieta1.moverObstaculos()})
		game.onTick(1000, "mov", {if(game.hasVisual(grieta2))grieta2.moverObstaculos()})
	
	}
	

	method graficosIndicadores(){
		game.addVisual(indicadorCombus)
		game.addVisual(reloj)
		reloj.iniciar()
	}
}

object fondo{
	const property image = "Assets/FondoNivel0.jpg"
	var property position = game.at(0,0)
	var bucle = 0
	method movimiento(){
		game.onTick(600,"movMapa",{position = position.down(1);bucle = bucle + 1; if (bucle == 5) {position = game.at(0,0) bucle = 0}})
		
	}
}

///////// Cosas con la que el jugador puede chocar //////////////
class SuperObstaculos {
	
	const property listaPosiciones= [game.at(8,13),game.at(1,13), game.at(3,13), game.at(5,13), game.at(8,15), game.at(5,15), game.at(3,15), game.at(9,15), game.at(6,15) ]
	const property listaReinicio = [-1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11, -14, -15, -20, -25]
	
	var property position = listaPosiciones.anyOne()
	

	method moverObstaculos(){
		position = position.down(1)
		if(position.y() <= listaReinicio.anyOne()) position = listaPosiciones.anyOne() // Si la posicion del obstaculo es igual o menor a alguna al azar de la lista
																  // Vuelve a una posición inicial aleatoria
		}
		


	
	method chocar(){
		game.removeVisual(self)
	}

	

}





class AutoEnemigo inherits SuperObstaculos {

	var property image = "Assets/enemRojo.png"
	
	override method chocar(){
		game.stop()
		super()
	}
	
	method serImpactado(){
		game.schedule(3000,position = listaReinicio.anyOne())
	}

	
}

class AutoEnemigoV inherits SuperObstaculos{
	var property  image = "Assets/EnemVerde.png"
	
	override method chocar(){
		game.stop()
		super()
	}
	method serImpactado(){
		game.schedule(3000,position = listaReinicio.anyOne())
	}
}

class AutoEnemigoA inherits SuperObstaculos{
	var property image = "Assets/EnemAmarillo.png"
	override method chocar(){
		game.stop()
		super()
	}
	method serImpactado(){
		game.schedule(3000,position = listaReinicio.anyOne())
	}
}

class Camion inherits SuperObstaculos{
	var property image ="Assets/camion.png"
	override method chocar(){
		game.stop()
		super()
	}
	method serImpactado(){
		game.schedule(5000,position = listaReinicio.anyOne())
	}
}
class Grieta inherits SuperObstaculos{

	var property image = "Assets/Grieta.png"
	
	const property combustDism = 350
	override method chocar(){
		jugador.combust(jugador.combust() - combustDism)
		super()

	}

}

class ManchaDeCombustible inherits SuperObstaculos{

	var property image = "Assets/Mancha.png"
	
	const property combustDism = 200
	
	override method chocar(){
		jugador.combust(jugador.combust() - combustDism)
		super()
	}
}

class ObjetoObtenerPoder inherits SuperObstaculos{

	
	const property image = "Assets/ObtenerPoder.png"


	
	override method chocar(){
		if (jugador.baul() == [ ]) jugador.agregarPoder() else game.say(jugador,"Solo puedo tener un poder a la vez")
		super()
	}
}

class CargaCombust inherits SuperObstaculos{
	const property image = "Assets/BidonComb.png"
	override method chocar(){
		const sumarCombust = jugador.combust() + 600
		jugador.combust(sumarCombust)
		position = game.schedule(15000,position = listaReinicio.anyOne()
		)
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