import wollok.game.*
import Jugador.*


object juego{
	method iniciar(){
		self.graficosBase()
		self.seleccionDeDificultad()
		self.pantalla_De_Inicio()
		game.start()
	}
	method pantalla_De_Inicio(){
		game.addVisual(fondo1)
		game.addVisual(fondoZ)
		keyboard.z().onPressDo {
			game.removeVisual(fondo1)
			game.removeVisual(fondoZ)
		}
	}
	method seleccionDeDificultad(){
		game.addVisual(fondo2)
		keyboard.num1().onPressDo {
			game.removeVisual(fondo2)		
			self.controlesJugador()
        	self.obstaculos()
			self.graficosIndicadores()
		}
	}
	
	method graficosBase(){
		game.cellSize(64) 
		game.width(20) 
		game.height(13.5)
		game.title("Road Race Powered")
		game.addVisual(fondo)
		fondo.movimiento()
		reloj.iniciar()
		reloj.meta()
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
		const autoER5 = new AutoEnemigo()
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
		game.schedule(listaAparicion.anyOne(),{game.addVisual(autoER5)})
	
		
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

		game.onTick(800, "mov", {if(game.hasVisual(autoER2))autoER1.moverObstaculos()
								if(game.hasVisual(autoER2))autoER2.moverObstaculos()
								if(game.hasVisual(autoER3))autoER3.moverObstaculos()
								if(game.hasVisual(autoER4))autoER4.moverObstaculos()
								if(game.hasVisual(autoER5))autoER5.moverObstaculos()
								if(game.hasVisual(autoA1))autoA1.moverObstaculos()
								if(game.hasVisual(autoA2))autoA2.moverObstaculos()
								if(game.hasVisual(autoV))autoV.moverObstaculos()
								if(game.hasVisual(autoV2))autoV2.moverObstaculos()
								if(game.hasVisual(autoV3))autoV3.moverObstaculos()
								if(game.hasVisual(comb))comb.moverObstaculos()
								if(game.hasVisual(comb2))comb2.moverObstaculos()
								if(game.hasVisual(pod1))pod1.moverObstaculos()
								if(game.hasVisual(pod2))pod2.moverObstaculos()
								if(game.hasVisual(grieta1))grieta1.moverObstaculos()
								if(game.hasVisual(grieta2))grieta2.moverObstaculos()
								if(game.hasVisual(mancha1))mancha1.moverObstaculos()
								if(game.hasVisual(mancha2))mancha2.moverObstaculos()}) 						
	
		game.onTick(500,"moveV",{if(game.hasVisual(autoV))autoV.cambiarPosV()
									if(game.hasVisual(autoV2))autoV2.cambiarPosV()
									if(game.hasVisual(autoV3))autoV3.cambiarPosV()})
									
		game.onTick(500,"moveA",{if(game.hasVisual(autoA1))autoA1.cambiarPosA()
									if(game.hasVisual(autoA2))autoA2.cambiarPosA()})
	
	}
	

	method graficosIndicadores(){
		game.addVisual(indicadorCombus)
		game.addVisual(reloj)
		reloj.iniciar()
		game.addVisual(indicadorPoder)
		barraPoder.cargarPoder()
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
	method pantalla_De_Inicio(){
		game.addVisual(fondo1)
		keyboard.z().onPressDo {
			game.removeVisual(fondo1)
			
			}
		}
	}

object fondo1 {
	var property image = "Assets/PantallaDeInicio.jpg"
	var property position = game.at(0,0)
	}

object fondo2 {
	var property image = "Assets/SeleccionDeNivel.jpg"
	var property position = game.at(0,0)
	}

object fondoZ {
	var property image = "Assets/pulseZ.png"
	var property position = game.at(0,0)
	}


///////// Cosas con la que el jugador puede chocar //////////////
class SuperObstaculos {
	
	const property listaPosiciones= [game.at(2,13),game.at(4,13), game.at(6,13), game.at(8,13), game.at(10,13), game.at(2,15), game.at(4,15), 
									game.at(6,15), game.at(8,15),game.at(10,15), game.at(2,20),game.at(4,20),game.at(6,20),game.at(8,20),
									game.at(10,20)]
	const property listaReinicio = [-1, -4, -7, -11, -15]
	const property movEspecial = [ 2 , 4]
	

	
	
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
	
	method cambiarPosV(){ // Priorizan moverse dos carriles, se suelen trabar fácil (a propósito)
		if(position.y() > 1 and position.x().between(2,4) and game.getObjectsIn(position.right(2)).isEmpty() and game.getObjectsIn(position.right(4)).isEmpty())     position = position.right(movEspecial.anyOne()) 
		else if(position.y() > 1 and position.x().between(8,10) and game.getObjectsIn(position.left(2)).isEmpty() and game.getObjectsIn(position.left(4)).isEmpty()) position = position.left(movEspecial.anyOne())
		else if(position.y() > 1 and position.x() == 6 and game.getObjectsIn(position.left(4)).isEmpty()) position = position.left(4)
		else if(position.y() > 1 and position.x() == 6 and game.getObjectsIn(position.right(4)).isEmpty()) position = position.right(4)
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
	
	method cambiarPosA(){ // Priorizan moverse un carril y casi nunca se traban
		if(position.y() > 1 and position.x().between(2,6) and game.getObjectsIn(position.right(2)).isEmpty())position = position.right(2)
		else if(position.y() > 1 and position.x().between(8,10) and game.getObjectsIn(position.left(2)).isEmpty())position = position.left(2)
		else if(position.y() > 1 and position.x().between(2,6) and game.getObjectsIn(position.right(4)).isEmpty())position = position.right(4)
		else if(position.y() > 1 and position.x().between(8,10) and game.getObjectsIn(position.left(4)).isEmpty())position = position.left(4)
		else if(position.y() > 1 and position.x() == 6 and (game.getObjectsIn(position.left(4)).isEmpty())) position = position.left(4)
		else if(position.y() > 1 and position.x() == 6 and game.getObjectsIn(position.right(4)).isEmpty()) position = position.right(4)
		else if(position.y() > 1 and position.x() == 6 and game.getObjectsIn(position.left(2)).isEmpty()) position = position.left(2)
		else if(position.y() > 1 and position.x() == 6 and game.getObjectsIn(position.right(2)).isEmpty()) position = position.right(2)
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
		const cargaPoder = barraPoder.poder() + 25
		barraPoder.poder(cargaPoder)
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

object barraPoder{
	var property poder = 100
	method iniciarPoder(){
		poder = 100.min(poder + 1) //No funciona
	}
	method cargarPoder(){
		game.onTick(100,"cargarPoder",{self.iniciarPoder()})
	}
}

object indicadorPoder{
	const property position = game.at(14,5)
	var property image = if(barraPoder.poder().between(0,49)) "Assets/poder0.png"
					    else if(barraPoder.poder().between(50,99)) "Assets/poder50.png"
					    else "Assets/poder100.png"
	// Esto no cambia automaticamente
}

object indicadorCombus{
	
	const property position = game.at(15,2)
	var property image = if(jugador.combust().between(700,1000)) "Assets/bidonVerde.png"
						 else if(jugador.combust().between(400,699)) "Assets/bidonAmarillo.png"
						 else "Assets/bidonRojo.png"
	}
	
	object reloj {
	var property tiempo = 0
	const property position = game.at(15 ,11)
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
	method meta(){
		game.onTick(60000,"meta",{juego.victoria()})
	}
}
