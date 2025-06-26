import wollok.game.*
import main.*
import direcciones.*
import enemigos.*
import jueguito.*
import agarrables.*
import sonic.*


class ElementoVisual{
    var property position

    method afectar(personaje) {
        personaje.position(personaje.direccion().opuesto().proximaPosicion(personaje.position()))
        personaje.estaMoviendose(false)
    }
}

class Arbol inherits ElementoVisual{
    const property image = "arbustos2_resized_32x32.png"
}

class Vida inherits ElementoVisual{
    var property image = "vida32x32.png" 
}

class Fondo{
    var property image = "fondo.png"
    const property position = game.origin()
    const arboles = new List()
    const vidasJuego = new List()

    method inicializarArboles(){

        //cambiar nombres de las variables 
        const posX = new Range(start = 0, end = game.width()-1)
        const posY = new Range(start = 0, end = game.height()-2)
        

        posX.forEach{ x => arboles.add(new Arbol(position = game.at(x, posY.start()))) } // x=[1,14] y=0 arboles de abajo
        posX.forEach{ x => arboles.add(new Arbol(position = game.at(x, posY.end()))) }
        posY.forEach{ y => arboles.add(new Arbol(position = game.at(posX.start(), y))) } // x=0 y=[1,14] arboles de izquierda
        posY.forEach{ y => arboles.add(new Arbol(position = game.at(posX.end(), y))) } // x=14 y=[1,14] arboles de derecha

        arboles.forEach{ arbol => juego.agregar(arbol) }
    }        

    method agregarVida(posicion){
        const vida = new Vida(position = posicion)
        vidasJuego.add(vida)
    }
    method agregarNuevaVida() {
        const vida = new Vida(position = vidasJuego.last().position().right(1))
        vidasJuego.add(vida)
        juego.agregar(vida)
    }

    method removerVida() {
        juego.eliminar(vidasJuego.last())
        vidasJuego.remove(vidasJuego.last())
    }

    method visualizarHud(){
        const range = new Range(start = game.width()-3, end =  game.width()-1)
        range.forEach{x => self.agregarVida(game.at(x, game.height()- 1))}
        vidasJuego.forEach{ vidas => juego.agregar(vidas) }
        
        const monedaHud = new Moneda(position = game.at(0,19))
        juego.agregar(monedaHud)

        juego.agregar(contadorMoneda)

        const pocionPoderHud = new Pocion(tipo = poder , position = game.at(5,19))
        juego.agregar(pocionPoderHud)
        
        juego.agregar(contadorPocionPoderHud)

        juego.agregar(imagenParaDificultad)
        juego.agregar(mostrarDificultad)
    }

    method aplicarEfectoPorEnemigo() {
        self.cambiarImagen("fondoWB.png")
        game.schedule(100, {self.cambiarImagen("fondo.png")})
    }
    method cambiarImagen(nuevaImagen){
        image = nuevaImagen
    }



}
object contadorMoneda {
    const property position = game.at(2,19)
    
    method text() = "Monedas: " + sonic.cantMonedas().toString()
    method textColor() = paleta.negro()
}

object contadorPocionPoderHud {
    const property position = game.at(7,19)

    method text() = "Pocion Rodar: " + sonic.cantPocionesPoder()
    method textColor() = paleta.negro()
}

object imagenParaDificultad{
    const property position = game.at(11,19) 
    const property image = "dificultad.png" 

}
object mostrarDificultad{
    const property position = game.at(13,19)
    method dificultadString(){
        if(juego.nivel().esFacil()){
            return "Facil"
        }else if(juego.nivel().esMedio() ){
            return "Medio"
        }else {
            return "Dificil"
        }
    }
    
    method text()= "Dificultad: " + self.dificultadString()
    method textColor() = paleta.negro()
}

object paleta {
  const property negro = "000000"
}