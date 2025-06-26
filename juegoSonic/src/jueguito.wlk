import wollok.game.*
import direcciones.* 
import agarrables.*
import enemigos.*
import sonic.* 
import fondo.*
import escenarios.*

// ESTRUCTURA DEL JUEGO
object juego{
    var property nivel = new Nivel1()
    var portada = new PortadaInicio()
    var musicaFondo = game.sound("musicaInicio.mp3")
    var objetos = new List()
    var onTicks = new List()

    // Reinicia el juego 
    method reset(){
        self.eliminarTodos()
        sonic.resetearSonic()
        self.iniciarNivel(new Nivel1())
        //self.iniciar()
    }

    // Cambiar la musica de fondo
    method cambiarMusica(nuevaMusica){
        musicaFondo.stop()
        musicaFondo = nuevaMusica
        musicaFondo.play()
    }
    // Agregar y eliminar objetos del juego
    method agregar(objeto){
        game.addVisual(objeto)
        objetos.add(objeto)
    }
    method eliminar(objeto){
        game.removeVisual(objeto)
        objetos.remove(objeto)
    }
    method eliminarTodos(){
        objetos.forEach{objeto => self.eliminar(objeto)}
        onTicks.forEach{nombre => self.eliminarOnTick(nombre)}
    }
    method agregarOnTick(milis, nombre, accion){
        onTicks.add(nombre)
        game.onTick(milis, nombre, accion)
    }
    method eliminarOnTick(nombre){
        onTicks.remove(nombre)
        game.removeTickEvent(nombre)
    }
    method hasVisual(visual) = objetos.contains(visual)
    


    // Inicio y configuracion inicial del juego
    method iniciar(){
        musicaFondo.play()
        portada.configurar()
        self.configurarControles()
        game.start()
    }
    // Iniciar un nuevo nivel
    method iniciarNivel(nuevoNivel){
        nivel = nuevoNivel
        nivel.configurar()
    }
    // Cambiar la portada (lo usa sonic)
    method cambiarPortada(nuevaPortada){
        portada = nuevaPortada
        portada.configurar()
    }
    method portada() = portada
    // Controles de Sonic
    method configurarControles(){
        keyboard.right().onPressDo{
            sonic.cambiarDireccion(derecha)
            sonic.empezarAMoverse()
        }
        keyboard.left().onPressDo{
            sonic.cambiarDireccion(izquierda)
            sonic.empezarAMoverse()
        }
        keyboard.up().onPressDo{
            sonic.cambiarDireccion(arriba)
            sonic.empezarAMoverse()
        }
        keyboard.down().onPressDo{
            sonic.cambiarDireccion(abajo)
            sonic.empezarAMoverse()
        }
        keyboard.space().onPressDo{
            sonic.empezarARodar()
        }
        keyboard.enter().onPressDo{
            portada.onPressEnter()
        }
    }


    // Elementos del inicio del juego
    method agregarElementosIniciales(){
        self.agregarSonic()
        self.insertarMonedaEnElEscenario()
        self.insertarPocionPoderEnElEscenario()
        // self.insertarPocionSumaVidaEnElEscenario()        
    }

    method agregarSonic() {
        // Posiciona a sonic en el centro de la pantalla y lo agrega al juego
        sonic.empezaEn(game.center())
        self.agregar(sonic)
        game.say(sonic, "Consigue las monedas sin que te agarren!")
        self.agregarOnTick(100, "moverse", {
            if (sonic.estaMoviendose()) {
                sonic.move() // Mover a Sonic automáticamente en cada tick si está moviéndose
            }
        })
        
        game.onCollideDo(sonic, {algo => sonic.agarrar(algo)})
    }

    method generarEnemigo(enemigo) {
        self.agregar(enemigo)
        enemigo.seguirA(sonic)
    }

    // Genera monedas en el escenario
    method insertarMonedaEnElEscenario(){
        const moneda = new Moneda(position = self.posicionAleatoria())
        self.agregar(moneda)
    }
    method insertarPocionPoderEnElEscenario(){
        const pocionPoder = new Pocion(position = self.posicionAleatoria(), tipo = poder)
        self.agregar(pocionPoder)
    }

    method insertarPocionVidaEnElEscenario(){
         const pocionVida = new Pocion(position = self.posicionAleatoria(), tipo = sumaVida)
         self.agregar(pocionVida)
     }

    method posicionAleatoria() {
        const x = 1.randomUpTo(game.width() - 3)
        const y = 1.randomUpTo(game.height() - 3)
        return game.at(x, y)
    }

}

