import wollok.game.*
import main.*
import sonic.*
import direcciones.* 
import agarrables.* 
import fondo.*
import jueguito.*

class Enemigo{
  var property position

  method nombre()
  method seguirEnXA(personaje){
    if (personaje.position().x() > position.x()){
          position = position.right(1)
        } else if (personaje.position().x() < position.x()){
          position = position.left(1)
    } 
  }
  method seguirEnYA(personaje){
    if (personaje.position().y() > position.y()){
          position = position.up(1)
        } else if (personaje.position().y() < position.y()){
          position = position.down(1)
    } 
  }

  method desaparecer() {
    juego.eliminar(self)
  }

  method afectar(personaje){
    if(!personaje.estaRodando()){
      juego.nivel().fondo().aplicarEfectoPorEnemigo()
      self.afectarPorEnemigo(personaje)
      self.desaparecer()
    } 
    else {
      self.explotar()
    }
  }

  method afectarPorEnemigo(personaje)
  method explotar(){
    self.cambiarImagen("explosion.png")
    game.schedule(500, {self.desaparecer()})
  }
  method cambiarImagen(nuevaImagen){
    self.image(nuevaImagen)
  }
  method image(nuevaImagen)

}

class Avispa inherits Enemigo{
    
    var property image = "avispa32x32.png"

    override method nombre() = "Avispa"
    method seguirA(personaje){
      juego.agregarOnTick(600, "movimiento"+self.nombre() ,{self.seguirEnXA(personaje) self.seguirEnYA(personaje)})
    }

    override method afectarPorEnemigo(personaje){
      personaje.pierdeVida()
      if(personaje.cantMonedas() > 0){
      personaje.pierdeMoneda()
      }
    }
}

class Cangrejo inherits Enemigo{
  var property image = "cangrejo32x32.png"

    override method nombre() = "Cangrejo"
    method seguirA(personaje){
      juego.agregarOnTick(800, "movimiento"+self.nombre() ,{self.seguirEnXA(personaje)})
    }

    override method afectarPorEnemigo(personaje){
      personaje.pierdeVida()
      if(personaje.cantMonedas() > 0){
      personaje.pierdeMoneda()
      }
    }
}

class Pez inherits Enemigo{
  var property image = "pez32x32.png"

    override method nombre() = "Pez"
    method seguirA(personaje) {
      juego.agregarOnTick(1000, "movimiento"+self.nombre() ,{self.seguirEnXA(personaje) self.seguirEnYA(personaje)})
    }

    override method afectarPorEnemigo(personaje){
      personaje.pierdeVida()
    }
}