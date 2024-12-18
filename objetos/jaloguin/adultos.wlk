class Adulto {
    var nenesPesados = []
    var bolsaCaramelos

    method cantNenesPesados() = nenesPesados.filter({nene => nene.cantCaramelos() >= 15}).size()

    method tolerancia() = 10 * self.cantNenesPesados()

    method seAsustaCon(nene)

    method darCaramelos(nene, cant){ //me perdonas?
        nene.recibirCaramelos(cant)
        bolsaCaramelos -= cant
    }

    method cantCaramelosEntregados()
}

class Necio inherits Adulto {

    override method seAsustaCon(nene) = false

}

class Comun inherits Adulto {

    override method seAsustaCon(nene) = nene.capacidadDeAsustar() >= self.tolerancia()

    override method cantCaramelosEntregados() = bolsaCaramelos

    
}

class Abuelo inherits Comun { //:(

    override method cantCaramelosEntregados() = super() / 2
}
