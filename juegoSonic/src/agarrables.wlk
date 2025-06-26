import direcciones.*
import sonic.*
import fondo.*
import main.*
import enemigos.*
import wollok.game.* 
import jueguito.*


class Moneda{
    const property position
    const property image = "moneda.png" 

    method afectar(personaje){ 
        personaje.acumularMonedas()
        juego.nivel().configurarDificultad()
        juego.eliminar(self)
        juego.insertarMonedaEnElEscenario()
    }
}

class Pocion{
    const property position
    var tipo

    method afectar(personaje){
        tipo.afectar(personaje)
        juego.eliminar(self)
        juego.insertarPocionPoderEnElEscenario()
    }

    method image() = tipo.image()
}

// Tipos de pociones
object poder{ 
    const property image = "pocionPoder.png"

    method afectar(personaje){
        personaje.acumularPociones()
    }    
}

object sumaVida{
    const property image = "pocionVida2.png" 
    method afectar(personaje){
        personaje.sumarVida()
    }
}

