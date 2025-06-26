import wollok.game.*
import main.*
import sonic.*
import enemigos.*
import agarrables.* 
import fondo.*


class Direccion {
  method proximaPosicion(posicion)
  
  method imagen(estaRodando){
    if(estaRodando){
      return "sonicRodando1.png"
    }
    else return self.imagen()
  }
  method imagen()
}

class DireccionHorizontal inherits Direccion {
  override method proximaPosicion(posicion) {
    return posicion.right(self.sentido())
  }
  
  method sentido()
}
class DireccionVertical inherits Direccion {
  override method proximaPosicion(posicion) {
    return posicion.up(self.sentido())
  }

  method sentido()
}

//DIRECCIONES QUE LAS USAMOS PARA MOVER A SONIC
object arriba inherits DireccionVertical{
  override method sentido() = 1
  method opuesto() = abajo

  override method imagen(){
    return "sonicEspalda1.png"
  }
}
object derecha inherits DireccionHorizontal {
  override method sentido() = 1
  method opuesto() = izquierda

  override method imagen(){
    return "sonicDerecha1.png"
  }
}

object izquierda inherits DireccionHorizontal{
  override method sentido() = -1
  method opuesto() = derecha

  override method imagen(){
    return "sonicIzquierda1.png"
  }
}
object abajo inherits DireccionVertical{
  override method sentido() = -1
  method opuesto() = arriba

  override method imagen(){
    return "sonicFrente1.png"
  }
}
