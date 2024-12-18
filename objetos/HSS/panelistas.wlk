class Panelista{
    var property puntos

    method hacerRemateGracioso(tematica){
        self.aumentarPuntos(self.puntosRemate(tematica))
        self.postRemate()
    }

    method puntosRemate(tematica)

    method aumentarPuntos(cant) {
        puntos += cant
    }

    method postRemate(){
        //nada
    }

    method opina(tematica) {
        self.aumentarPuntos(1 + tematica.puntosExtra(self))
    }

    method esDeportivo() = false

    method esCelebridad() = false

    method emitir(tematica){
        self.opina(tematica)
        self.hacerRemateGracioso(tematica)
    }
}

class Celebridad inherits Panelista{

    override method puntosRemate(tematica) = 3

    override method esCelebridad() = true

}

class Colorado inherits Panelista{
    var gracia

    override method puntosRemate(tematica) = gracia / 5

    override method postRemate() {
        gracia += 1
    }
}

class ColoradoConPeluca inherits Colorado{

    override method puntosRemate(tematica) = super(tematica) + 1

}

class Viejo inherits Panelista{
    
    override method puntosRemate(tematica) = tematica.cantidadPalabras()

}

class Deportivos inherits Panelista{

    override method puntosRemate(tematica) = 0

    override method esDeportivo() = true
}