import wollok.game.*
import Jugador.*


object juego{
	const listaAparicion = [(500),(1000),(5000),(7000),(10000),(10500)]
	const listaAparicionN2 = [(500),(900),(3000),(5000),(8000),(10000)]
	const autoER1 = new AutoEnemigo()
	const autoER2 = new AutoEnemigo()
	const autoER3 = new AutoEnemigo()
	const autoER4 = new AutoEnemigo()
	const autoER5 = new AutoEnemigo()
	const autoER6 = new AutoEnemigo()
	const autoER7 = new AutoEnemigo()
	const autoA1 = new AutoEnemigoA()
	const autoA2 = new AutoEnemigoA()
	const autoA3 = new AutoEnemigoA()
	const autoV = new AutoEnemigoV()
	const autoV2 = new AutoEnemigoV()
	const autoV3 = new AutoEnemigoV()
	const autoV4 = new AutoEnemigoV()
	const pod1 = new ObjetoObtenerPoder()
	const pod2 = new ObjetoObtenerPoder()
	const grieta1 = new Grieta()
	const grieta2 = new Grieta()
	const grieta3 = new Grieta()
	const mancha1 = new ManchaDeCombustible()
	const mancha2 = new ManchaDeCombustible()
	const comb = new CargaCombust()
	const comb2 = new CargaCombust()
	
	method iniciar(){
		self.graficosBase()
		self.seleccionDeDificultad()
		self.instrucciones()
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
			self.nivel1()
        	self.obstaculosN1()
			self.graficosIndicadores()
			self.controlesJugador()
		}
		keyboard.num2().onPressDo {
			game.removeVisual(fondo2)
			self.nivel2()
			self.obstaculosN2()
			self.graficosIndicadores()
			self.controlesJugador()
		}
	}
	
	
	method graficosBase(){
		game.cellSize(64) 
		game.width(20) 
		game.height(13.5)
		game.title("Road Race Powered")
		fondo.movimiento()
		reloj.iniciar()
		reloj.meta()
		
	}
	method instrucciones(){
		game.addVisual(instrucciones)
		keyboard.x().onPressDo {
			game.removeVisual(instrucciones)
		}
	}
	
	method nivel1(){
		const m1 = game.sound("Audio/normalNivel1.mp3")
		m1.shouldLoop(true)
		game.addVisual(fondo)
		game.schedule(100,{m1.play()})
	}
	
	method nivel2(){
		const m2 = game.sound("Audio/normalNivel2.mp3")
		m2.shouldLoop(true)
		game.addVisual(fondoN2)
		m2.play()
	}
	

	
	
	method controlesJugador(){
		game.addVisual(jugador)
        keyboard.right().onPressDo({jugador.moverDerecha()})
		keyboard.left().onPressDo({jugador.moverIzquierda()})
		
		//interaccion con poderes//
		keyboard.q().onPressDo({if (barraPoder.poder() == 100){
			poderPuntos.activar()
			barraPoder.reset()
			}else{
				game.say(jugador,"No tengo el poder suficiente!")
			}
		})
		keyboard.w().onPressDo({if (barraPoder.poder() == 100){
			poderCombust.activar()
			barraPoder.reset()}else{
				game.say(jugador,"No tengo el poder suficiente!")
			}
		})
	
		// Colisiones
		game.onCollideDo(jugador,{elem => elem.chocar() })
	}
	
	method graficosIndicadores(){
		game.addVisual(indicadorCombus)
		jugador.gastarC()
		indicadorCombus.combustGM()
		game.addVisual(reloj)
		reloj.iniciar()
		game.addVisual(barraPoder)
		barraPoder.cargarPoder()
	}
	
	method obstaculosN2(){
		
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoER1)}) 
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoER2)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoER3)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoER4)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoER5)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoER6)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoER7)})
	
		
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoA1)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoA2)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoA3)})
		
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoV)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoV2)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoV3)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(autoV4)})
		
		
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(comb)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(comb2)})
		
		game.schedule(10000,{game.addVisual(pod1)})
		game.schedule(45000, {game.addVisual(pod2)})
		
		game.schedule(listaAparicionN2.anyOne(), {game.addVisual(grieta1)})
		game.schedule(listaAparicionN2.anyOne(), {game.addVisual(grieta2)})
		game.schedule(listaAparicionN2.anyOne(), {game.addVisual(grieta3)})
		
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(mancha1)})
		game.schedule(listaAparicionN2.anyOne(),{game.addVisual(mancha2)})

		game.onTick(700, "mov", {autoER1.moverObstaculos()
								autoER2.moverObstaculos()
								autoER3.moverObstaculos()
								autoER4.moverObstaculos()
								autoER5.moverObstaculos()
								autoER6.moverObstaculos()
								autoER7.moverObstaculos()
								
								autoA1.moverObstaculos()
								autoA2.moverObstaculos()
								autoA3.moverObstaculos()
								
								autoV.moverObstaculos()
								autoV2.moverObstaculos()
								autoV3.moverObstaculos()
								autoV4.moverObstaculos()
								
								comb.moverObstaculos()
								comb2.moverObstaculos()
								pod1.moverObstaculos()
								pod2.moverObstaculos()
								grieta1.moverObstaculos()
								grieta2.moverObstaculos()
								mancha1.moverObstaculos()
								mancha2.moverObstaculos()}) 						
	
		game.onTick(1300,"moveV",{autoV.cambiarPosEspecial()
					autoV2.cambiarPosEspecial()
					autoV3.cambiarPosEspecial()})
									
		game.onTick(1300,"moveA",{autoA1.cambiarPosEspecial()
					  autoA2.cambiarPosEspecial()})
	
	}
	method obstaculosN1(){

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

		game.onTick(1500, "mov", {autoER1.moverObstaculos()
					 autoER2.moverObstaculos()
					autoER3.moverObstaculos()
					autoER4.moverObstaculos()
					autoER5.moverObstaculos()
					autoA1.moverObstaculos()
					autoA2.moverObstaculos()
					autoV.moverObstaculos()
					autoV2.moverObstaculos()
					autoV3.moverObstaculos()
					comb.moverObstaculos()
					comb2.moverObstaculos()
					pod1.moverObstaculos()
					pod2.moverObstaculos()
					grieta1.moverObstaculos()
					grieta2.moverObstaculos()
					mancha1.moverObstaculos()
					mancha2.moverObstaculos()}) 						
	
		game.onTick(1500,"moveV",{autoV.cambiarPosEspecial()
					autoV2.cambiarPosEspecial()
					autoV3.cambiarPosEspecial()})
									
		game.onTick(1500,"moveA",{autoA1.cambiarPosEspecial()
					autoA2.cambiarPosEspecial()})
	
	}


	method victoria(){ 
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
	
object instrucciones {
	var property image = "Assets/Instrucciones.jpg"
	var property position = game.at(0,0)
}

object fondoZ {
	var property image = "Assets/pulseZ.png"
	var property position = game.at(0,0)
	}

object fondoN2{
const property image = "Assets/ultimoFondo.jpeg"
	var property position = game.at(0,0)
	var bucle = 0
	method movimiento(){
		game.onTick(800,"movMapa2",{position = position.down(1);bucle = bucle + 1; if (bucle == 5) {position = game.at(0,0) bucle = 0}})
	}
}


///////// Cosas con la que el jugador puede chocar //////////////
class SuperObstaculos {
	
	const property listaPosiciones= [game.at(2,13),game.at(4,13), game.at(6,13), game.at(8,13), game.at(10,13), game.at(2,15), game.at(4,15), 
									game.at(6,15), game.at(8,15),game.at(10,15), game.at(2,20),game.at(4,20),game.at(6,20),game.at(8,20),
									game.at(10,20)]
	const property listaReinicio = [-1, -4, -7, -11, -15]
	const property movEspecial = [ 2 , 4]
	

	//Los autos aparecen y desaparecen en posiciones diferentes, para generar mas aleatoriedad, y disminuir la probabilidad
	//de que se generen todos uno al lado del otro
	
	var property position = listaPosiciones.anyOne()
	
	
	method moverObstaculos(){
		if(game.hasVisual(self))
		position = position.down(1)
		if(position.y() <= listaReinicio.anyOne()) {position = listaPosiciones.anyOne() // Si la posicion del obstaculo es igual o menor a alguna al azar de la lista																  // Vuelve a una posición inicial aleatoria
		}
		
		}
	method chocar(){
		position = listaPosiciones.anyOne()
	}
	
	method serImpactado(){
		position = listaPosiciones.anyOne()
	}
	method cambiarPosEspecial(){}
	
	method posYMayor1andXentre(pos1,pos2) = position.y() > 1 and position.x().between(pos1,pos2) //preparación de cambiar posicion
	method posYmayor1andX6() = position.y() > 1 and position.x() == 6
	method comprobarPosVaciaDerecha(posObt1) =  game.getObjectsIn(position.right(posObt1)).isEmpty()
	
	method comprobarPosVaciaIzquierda(posObt1) = game.getObjectsIn(position.left(posObt1)).isEmpty()
}

class AutoEnemigo inherits SuperObstaculos {

	var property image = "Assets/enemRojo.png"
	
	override method chocar(){
		game.stop()

	}
	
}

class AutoEnemigoV inherits SuperObstaculos{
	var property  image = "Assets/EnemVerde.png"
	
	override method chocar(){
		game.stop()

	}
	
	override method cambiarPosEspecial(){ //Pregunta si la posicion y es mayor a 1 y pregunta s los bordes están libres, ya que prioriza estos bordes
					 	  // para moverse, si no se queda quieto, es normal que se quede quieto en un carril mas fecuente que el Amarillo
		if(game.hasVisual(self) and self.posYMayor1andXentre(2,4) and self.comprobarPosVaciaDerecha(2) and self.comprobarPosVaciaDerecha(4))  position = position.right(movEspecial.anyOne()) 
		else if(game.hasVisual(self) and self.posYMayor1andXentre(8,10) and self.comprobarPosVaciaIzquierda(2) and self.comprobarPosVaciaIzquierda(4)) position = position.left(movEspecial.anyOne())
		else if(game.hasVisual(self) and self.posYmayor1andX6() and self.comprobarPosVaciaIzquierda(4)) position = position.left(4)
		else if(game.hasVisual(self) and self.posYmayor1andX6() and self.comprobarPosVaciaDerecha(4)) position = position.right(4)
		}
	}

class AutoEnemigoA inherits SuperObstaculos{
	var property image = "Assets/EnemAmarillo.png"
	
	override method chocar(){
		game.stop()

	}


	override method cambiarPosEspecial(){ // Pregunta si la posicion 1 es mayor a 1 y la x entre un rango de carriles para moverse de una forma u otra
						 // Prioriza moverse un carril si la posicion de al lado está vacía, se mueve consistentemente
		if(game.hasVisual(self) and self.posYMayor1andXentre(2,6) and self.comprobarPosVaciaDerecha(2))position = position.right(2)
		else if(game.hasVisual(self) and self.posYMayor1andXentre(8,10) and self.comprobarPosVaciaIzquierda(2))position = position.left(2)
		else if(game.hasVisual(self) and self.posYMayor1andXentre(2,6) and self.comprobarPosVaciaDerecha(4))position = position.right(4)
		else if(game.hasVisual(self) and self.posYMayor1andXentre(8,10) and self.comprobarPosVaciaIzquierda(4))position = position.left(4)
		else if(game.hasVisual(self) and self.posYmayor1andX6() and self.comprobarPosVaciaIzquierda(4)) position = position.left(4)
		else if(game.hasVisual(self) and self.posYmayor1andX6() and self.comprobarPosVaciaDerecha(4)) position = position.right(4)
		else if(game.hasVisual(self) and self.posYmayor1andX6() and self.comprobarPosVaciaIzquierda(2)) position = position.left(2)
		else if(game.hasVisual(self) and self.posYmayor1andX6() and self.comprobarPosVaciaDerecha(2)) position = position.right(2)
		}
	}
		

class Grieta inherits SuperObstaculos{

	const property image = "Assets/Grieta.png"
	
	const property combustDism = 350
	override method chocar(){
		jugador.combust(0.max(jugador.combust() - combustDism))
		super()
	}
	
}

class ManchaDeCombustible inherits SuperObstaculos{

	const property image = "Assets/mancha0.png"
	
	const property combustDism = 200
	
	override method chocar(){
		jugador.combust(0.max(jugador.combust() - combustDism))
		super()
	}
}

class ObjetoObtenerPoder inherits SuperObstaculos{
	
	const property image = "Assets/ObtenerPoder.png"
	
	override method chocar(){
		const cargaPoder = barraPoder.poder() + 25
		barraPoder.poder(100.min(cargaPoder))
		super() 
	}
}

class CargaCombust inherits SuperObstaculos{
	const property image = "Assets/BidonComb.png"
	override method chocar(){
		const sumarCombust = jugador.combust() + 800
		jugador.combust(1000.min(sumarCombust))
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
	var property poder = 0
	
	
					    
	const property position = game.at(14,5)
	
	method image() = if(self.poder().between(0,49)) "Assets/poder0.png" 
						else if(self.poder().between(50,99))"Assets/poder50.png"
					    else "Assets/poder100.png"
	
	method iniciarPoder(){
		poder = 100.min(poder + 1)
	}
	
					    
	method cargarPoder(){
		game.onTick(100,"cargarPoder",{self.iniciarPoder()})
	}
	method reset() {
		poder = 0
	}
	
	
}

					    
	
	

object indicadorCombus{
	
	const property position = game.at(15,2)
	
	
	method image() = if(jugador.combust().between(700,1000))"Assets/bidonVerde.png"
						 else if(jugador.combust().between(400,699)) "Assets/bidonAmarillo.png"
						 else "Assets/bidonRojo.png"
						 
						 
	method combustGM() = game.onTick(100,"gameOC",{if(jugador.combust() <= 0) game.stop()})

	
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
		game.onTick(10000,"meta",{if(self.tiempo() >= 2000)juego.victoria()})// El ontick es para que no siempre empiece en los 1500, que haya mas aleatoriedad
	}
}


