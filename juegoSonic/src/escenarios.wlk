import wollok.game.*
import direcciones.* 
import agarrables.*
import enemigos.*
import sonic.* 
import fondo.*
import jueguito.*

// PORTADAS
class Portada {
    var property position = game.at(0,0)
    // codigo que da la musica
    method configurar(){
        self.configurarFondo()
        //self.configurarEnter()
        juego.cambiarMusica(self.musica())
    }
    method configurarFondo(){
        juego.agregar(self)
    }
    method configurarEnter(){
        keyboard.enter().onPressDo{
            self.onPressEnter()
        }
    }
    method onPressEnter()
    method musica()
}

class PortadaInicio inherits Portada {
    const property image = "portadaPrueba1122.png"
    const property musica= game.sound("musicaInicio.mp3")
    override method onPressEnter() {
        juego.eliminar(self)
        juego.iniciarNivel(new Nivel1())
    }
}

class PortadaFin inherits Portada {
    override method onPressEnter(){
        juego.eliminar(self)
        juego.reset()
    }
    override method configurar(){
        juego.eliminarOnTick("moverse")
        juego.eliminar(sonic)
        super()
    }
}

class GameOver inherits PortadaFin {
    var property image = "GAME_OVER.png"
    const property musica= game.sound("sonidoGAMEOVER.mp3")
}

class Win inherits PortadaFin {
    var property image = "winPOS2.png"
    const property musica= game.sound("sonidoGANASTE.mp3")
    // remover las monedas y pociones pero dejar a sonic
}

// NIVELES
class Nivel {
    var dificultad
    const property fondo

    method aumentarDificultad() {
        dificultad += 1
    }

    method esFacil() = (dificultad==0)
    method esMedio() = ( dificultad==1)
    method esDificil() = (dificultad==2)

    method configurar() {
        self.configurarFondo()
    }
    
    method configurarFondo()
    method detenerEnemigos()
}

class Nivel1 inherits Nivel (dificultad = 0, fondo = new Fondo()){

    override method configurar(){
        super()
        self.generarEnemigos()
        self.configurarDificultad()
        juego.agregarElementosIniciales()
        juego.cambiarMusica(game.sound("musicaFondo1.mp3"))
    }
    override method configurarFondo(){
        juego.agregar(fondo)
        fondo.inicializarArboles()
        fondo.visualizarHud()
    }
    method generarEnemigos() {
        self.generarPeces()
        if(dificultad > 0) {
            self.generarCangrejos()
            juego.agregarOnTick(12000, "generarPocion", {juego.agregar(new Pocion(position = juego.posicionAleatoria(), tipo = sumaVida))})
        }
        if(dificultad > 1) {
            self.generarAvispas()
        }
    }
    override method detenerEnemigos() {
        juego.eliminarOnTick("generarPez")
        juego.eliminarOnTick("generarCangrejo")
        juego.eliminarOnTick("generarAvispa")
    }

    method generarPeces() {
        juego.agregarOnTick(7000, "generarPez", {juego.generarEnemigo(new Pez(position = juego.posicionAleatoria()))})
    }

    method generarCangrejos() {
        juego.agregarOnTick(8000, "generarCangrejo", {juego.generarEnemigo(new Cangrejo(position = juego.posicionAleatoria()))})
    }

    method generarAvispas() {
        juego.agregarOnTick(10000, "generarAvispa", {juego.generarEnemigo(new Avispa(position = juego.posicionAleatoria()))})
    }

    method configurarDificultad() {
        if((sonic.cantMonedas()>5 && self.esFacil()) || sonic.cantMonedas()>7 && self.esMedio()) {
            self.aumentarDificultad()
            self.generarEnemigos()
        }
        
    }
}