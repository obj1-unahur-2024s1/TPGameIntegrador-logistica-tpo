import wollok.game.*
import Jugador.*


object juego{
	method iniciar(){
		self.graficosBase()
		self.controlesJugador()
        self.obstaculos()
		self.graficosIndicadores()
		self.victoria()
		game.start()
	}
	
	method graficosBase(){
		game.cellSize(64) 
		game.width(20) 
		game.height(13.5) 
		game.title("Road Race Powered")
		game.addVisual(fondo)
		fondo.movimiento()
	}

	
	method controlesJugador(){
		game.addVisual(jugador)
        keyboard.right().onPressDo({jugador.moverDerecha()})
		keyboard.left().onPressDo({jugador.moverIzquierda()})
		
		//interaccion con poderes//
		keyboard.z().onPressDo({jugador.activarPoder()})
		// Colisiones
		game.whenCollideDo(jugador,{elem => elem.chocar() })
	}
	
	method obstaculos(){

		const listaAparicion = [(500),(1000),(5000),(7000),(10000),(10500)]
		const autoER1 = new AutoEnemigo()
		const autoER2 = new AutoEnemigo()
		const autoER3 = new AutoEnemigo()
		const autoER4 = new AutoEnemigo()
		const autoA1 = new AutoEnemigoA()
		const autoA2 = new AutoEnemigoA()
		const autoV = new AutoEnemigoV()
		const autoV2 = new AutoEnemigoV()
		const autoV3 = new AutoEnemigoV()
		const pod1 = new ObjetoObtenerPoder()
		const pod2 = new ObjetoObtenerPoder()
		const grieta1 = new Grieta()
		const grieta2 = new Grieta()
		const grieta3 = new Grieta()
		const mancha1 = new ManchaDeCombustible()
		const mancha2 = new ManchaDeCombustible()
		const comb = new CargaCombust()
		const comb2 = new CargaCombust()
		
		
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoER1)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoER2)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoER3)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoER4)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoA1)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoA2)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoV)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoV2)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoV3)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(comb)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(comb2)})
		game.schedule(10000,{game.addVisual(pod1)})
		game.schedule(45000, {game.addVisual(pod2)})
		game.schedule(listaAparicion.anyOne(), {game.addVisual(grieta1)})
		game.schedule(listaAparicion.anyOne(), {game.addVisual(grieta2)})
		game.schedule(listaAparicion.anyOne(), {game.addVisual(grieta3)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(mancha1)})
		game.schedule(listaAparicion.anyOne(),{game.addVisual(mancha2)})
		game.onTick(800, "mov",{if(game.hasVisual(autoER1))autoER1.moverObstaculos()})
		game.onTick(800, "mov", {if(game.hasVisual(autoER2))autoER2.moverObstaculos()}) 
		game.onTick(800, "mov", {if(game.hasVisual(autoER3))autoER3.moverObstaculos()})
		game.onTick(800, "mov", {if(game.hasVisual(autoER4))autoER4.moverObstaculos()})
		game.onTick(800, "mov",{if(game.hasVisual(autoA1))autoA1.moverObstaculos()})
		game.onTick(800, "mov",{if(game.hasVisual(autoA2))autoA2.moverObstaculos()})
		game.onTick(800, "mov",{if(game.hasVisual(autoV))autoV.moverObstaculos()})
		game.onTick(800, "mov",{if(game.hasVisual(autoV2))autoV2.moverObstaculos()})
		game.onTick(800, "mov",{if(game.hasVisual(autoV3))autoV3.moverObstaculos()})
		game.onTick(800, "mov",{if(game.hasVisual(comb))comb.moverObstaculos()})
		game.onTick(800, "mov",{if(game.hasVisual(comb2))comb2.moverObstaculos()})
		game.onTick(800, "mov", {if(game.hasVisual(pod1))pod1.moverObstaculos()})
		game.onTick(800, "mov", {if(game.hasVisual(pod2))pod2.moverObstaculos()})
		game.onTick(800, "mov", {if(game.hasVisual(grieta1))grieta1.moverObstaculos()})
		game.onTick(800, "mov", {if(game.hasVisual(grieta2))grieta2.moverObstaculos()})
		game.onTick(800, "mov", {if(game.hasVisual(mancha1))mancha1.moverObstaculos()})
		game.onTick(800, "mov", {if(game.hasVisual(mancha1))mancha1.moverObstaculos()})
	
	}
	

	method graficosIndicadores(){
		game.addVisual(indicadorCombus)
		game.addVisual(reloj)
		reloj.iniciar()
		game.addVisual(cajaPoder)
		jugador.andar()
		
	}
	
	method victoria(){ //tienen que ser varias, porque una imagen larga no sirve porque no colisiona |  No me funciona el puntaje, faltaría ese if
						//Faltaría el if reloj.tiempo >= 100 (ej) pero no funcionaba el reloj.tiempo CREO que es ese el problema
		const l0 = new LineaDeMeta(position = game.at(2,12))
		const l1 = new LineaDeMeta(position = game.at(3,12))
		const l2 = new LineaDeMeta(position = game.at(4,12))
		const l3 = new LineaDeMeta(position = game.at(5,12))
		const l4 = new LineaDeMeta(position = game.at(6,12))
		const l5 = new LineaDeMeta(position = game.at(7,12))
		const l6 = new LineaDeMeta(position = game.at(8,12))
		const l7 = new LineaDeMeta(position = game.at(9,12))
		const l8 = new LineaDeMeta(position = game.at(10,12))
		const l9 = new LineaDeMeta(position = game.at(1,12))
		game.addVisual(l0)
		game.addVisual(l1)
		game.addVisual(l2)
		game.addVisual(l3)
		game.addVisual(l4)
		game.addVisual(l5)
		game.addVisual(l6)
		game.addVisual(l7)
		game.addVisual(l8)
		game.addVisual(l9)
		game.onTick(700,"moverV",{if(game.hasVisual(l0))l0.mover()})
		game.onTick(700,"moverV",{if(game.hasVisual(l1))l1.mover()})
		game.onTick(700,"moverV",{if(game.hasVisual(l2))l2.mover()})
		game.onTick(700,"moverV",{if(game.hasVisual(l3))l3.mover()})
		game.onTick(700,"moverV",{if(game.hasVisual(l4))l4.mover()})
		game.onTick(700,"moverV",{if(game.hasVisual(l5))l5.mover()})
		game.onTick(700,"moverV",{if(game.hasVisual(l6))l6.mover()})
		game.onTick(700,"moverV",{if(game.hasVisual(l7))l7.mover()})
		game.onTick(700,"moverV",{if(game.hasVisual(l8))l8.mover()})
		game.onTick(700,"moverV",{if(game.hasVisual(l9))l9.mover()})

		}
}
object fondo{
	const property image = "Assets/FondoNivel0.jpg"
	var property position = game.at(0,0)
	var bucle = 0
	method movimiento(){
		game.onTick(800,"movMapa",{position = position.down(1);bucle = bucle + 1; if (bucle == 5) {position = game.at(0,0) bucle = 0}})
		
	}
}

object cajaPoder{
	const property image = "Assets/cuadroPoder.png"
	const property position = game.at(14,5)
}


///////// Cosas con la que el jugador puede chocar //////////////
class SuperObstaculos {
	
	const property listaPosiciones= [game.at(2,13),game.at(4,13), game.at(6,13), game.at(8,13), game.at(10,13), game.at(2,15), game.at(4,15), 
									game.at(6,15), game.at(8,15),game.at(10,15), game.at(2,20),game.at(4,20),game.at(6,20),game.at(8,20),
									game.at(10,20)]
	const property listaReinicio = [-1, -4, -7, -11, -15]
	
	var property position = listaPosiciones.anyOne()
	
	
	method moverObstaculos(){
		position = position.down(1)
		if(position.y() <= listaReinicio.anyOne()) {position = listaPosiciones.anyOne() // Si la posicion del obstaculo es igual o menor a alguna al azar de la lista																  // Vuelve a una posición inicial aleatoria
		}
	}
	method chocar(){
		position = listaPosiciones.anyOne()
	}
	method serImpactado(){}

}

class AutoEnemigo inherits SuperObstaculos {

	var property image = "Assets/enemRojo.png"
	
	override method chocar(){
		game.stop()

	}
	
	override method serImpactado(){
		position = listaPosiciones.anyOne()
	}

	
}

class AutoEnemigoV inherits SuperObstaculos{
	var property  image = "Assets/EnemVerde.png"
	
	override method chocar(){
		game.stop()

	}
	override method serImpactado(){
		position = listaPosiciones.anyOne()
	}
}

class AutoEnemigoA inherits SuperObstaculos{
	var property image = "Assets/EnemAmarillo.png"
	override method chocar(){
		game.stop()

	}
	override method serImpactado(){
		position = listaPosiciones.anyOne()
	}
}

class Grieta inherits SuperObstaculos{

	const property image = "Assets/Grieta.png"
	
	const property combustDism = 350
	override method chocar(){
		jugador.combust(jugador.combust() - combustDism)
		super()
	}
	
}

class ManchaDeCombustible inherits SuperObstaculos{

	const property image = "Assets/mancha0.png"
	
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
		super()
	}
}


class LineaDeMeta{
	const property image = "Assets/Linea0.png"
	var property position
	method mover(){
		position = position.down(1)
	}
	method chocar(){
		game.stop()
	}
}


/////////////////////////////////////////////////////////////////////////////




//////////// Zona de Indicadores ////////////////

object indicadorCombus{
	
	const property position = game.at(15,2)
	var property image = if(jugador.combust().between(700,1000)) "Assets/bidonVerde.png"
						 else if(jugador.combust().between(400,699)) "Assets/bidonAmarillo.png"
						 else "Assets/bidonRojo.png"
	}



object reloj {
	
	var property tiempo = 60 
	var property image = "Puntos = " + tiempo.toString()
	const property position = game.at(15,11)
	
	method pasarTiempo() {
		tiempo = tiempo +20
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