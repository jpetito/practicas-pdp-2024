class Tematica{
    var property titulo

    method cantidadPalabras() = titulo.words().size()

    method puntosExtra(panelista)

    method esInteresante() = false

    method puntosParaAumentar() = 0
}

class Deportiva inherits Tematica{
    
    override method puntosExtra(panelista) {
        if(panelista.esDeportivo()){
            return 5
        } else return 0
    }

    override method esInteresante() = titulo.contains("Messi")
}

class Farandula inherits Tematica{
    const involucrados = #{}

    override method puntosExtra(panelista) {
        if(panelista.esCelebridad()){
            return self.cantInvolucrados()
        } else return 0
    }

    method cantInvolucrados() = involucrados.size()

    override method esInteresante() = self.cantInvolucrados() >= 3


}

class Filosofica inherits Tematica{

    override method esInteresante() = self.cantidadPalabras() > 20
}

class Economica inherits Tematica{}

class Moral inherits Tematica{}

class Mixtas inherits Tematica{
    const tematicas = #{}

    override method titulo() = tematicas.map({tematica => tematica.titulo()}).join()

    override method esInteresante() = tematicas.any({tematica => tematica.esInteresante()})

    method puntosExtraTotales(panelista) = tematicas.sum({tematica => tematica.puntosExtra()})

    override method puntosExtra(panelista) = self.puntosExtraTotales(panelista)
}
