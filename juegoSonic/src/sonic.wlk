import jueguito.*
import wollok.game.*
import main.*
import direcciones.*
import enemigos.* 
import agarrables.* 
import fondo.*
import escenarios.*

// JUGADOR PRINCIPAL
object sonic {
  var property position = game.center()
  var property direccion = abajo
  var property estaMoviendose = false
  var property estaRodando = false
  var property vida = 3
  var property cantMonedas = 0
  var property cantPocionesPoder = 0

  // Método para cambiar la dirección de Sonic
  method cambiarDireccion(nuevaDireccion){
    direccion = nuevaDireccion
    self.image()
  }

  // Método para empezar el movimiento
  method empezarAMoverse() {
    estaMoviendose = true // Marca que Sonic está moviéndose
  }
  
  method empezarARodar() {
    if(cantPocionesPoder>0){
      estaRodando = true
      game.schedule(1000, {estaRodando = false})
      cantPocionesPoder-=1
    }
  }

  // Metodo para cambiar imagen de sonic respecto a la direccion 
  method image(){
    return direccion.imagen(estaRodando)
  }

  method empezaEn(posicionInicial){
    position = posicionInicial
  }

  method move(){
    position = direccion.proximaPosicion(position)
  
  }

  method pierdeVida(){
    vida -= 1
    juego.nivel().fondo().removerVida()
    if(vida <= 0 ) {
      juego.nivel().detenerEnemigos()
      juego.cambiarPortada(new GameOver())
    }

  }

  method resetearSonic(){
    position = game.center()
    estaMoviendose = false
    vida = 3
    cantMonedas = 0
    cantPocionesPoder = 0
  }

  
  method agarrar(algo) {
    algo.afectar(self)
  }
  
  method acumularPociones(){
    cantPocionesPoder += 1
  }

  method acumularMonedas() {
    cantMonedas += 1
    if(cantMonedas == 15) {
      juego.nivel().detenerEnemigos() // estaria para remover todos los enemigos, y no solo que se dejen de mover
      juego.cambiarPortada(new Win())

    } 
  }

  method sumarVida(){
    if(vida < 3){
      vida += 1
      juego.nivel().fondo().agregarNuevaVida()
    }
    

}
  method pierdeMoneda() {
    cantMonedas -= 1
  }
}