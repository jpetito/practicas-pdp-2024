class Personaje{
    const property fuerza
    const property inteligencia
    var rol

    method potencialOfensivo(){
        10 * fuerza + rol.potencialOfensivoExtra()
    }

    method esGroso() = self.esInteligente() || rol.esGroso(self)

    method esInteligente()
}

class Humano inherits Personaje{
    override method esInteligente() = inteligencia > 50
}

class Orco inherits Personaje{
    override method potencialOfensivo(){
        super() * 1.1
    }
    override method esInteligente() = false
}

///ROLES

object guerrero{
    method potencialOfensivoExtra() = 100

    method esGroso(personaje) = personaje.fuerza > 50

}

object brujo{
    method potencialOfensivoExtra() = 0

    method esGroso(personaje) = true
}

object cazador {
    var mascota

    method potencialOfensivoExtra() = mascota.potencialOfensivo()
    // method potencialOfensivoExtra(){
    //     if (mascota.tieneGarras){
    //         return mascota.fuerza * 2
    //     } else mascota.fuerza
    // }

    method esGroso(personaje) = mascota.esLongeva()

}

object mascota {
    const fuerza
    const edad
    var tieneGarras

    method esLongeva() = edad > 10 


    method potencialOfensivo(){
        if (tieneGarras){
        return fuerza * 2
        } else fuerza
    }
}

// ZONAS

class Ejercito {
    const property miembros = []

    method potencialOfensivo() = miembros.sum{ personaje => personaje.potencialOfensivo()}

    method invadir(zona){
        if(zona.potencialOfensivo() < self.potencialOfensivo()){
            zona.serOcupadaPor(self)
        }
    }
}

class Zona{
    var habitantes

    method potencialOfensivo() = habitantes.potencialOfensivo()

    method serOcupadaPor(ejercito){ habitantes = ejercito }
}

class Ciudad inherits Zona{
    override method potencialOfensivo() = super() + 300

}

class Aldea inherits Zona{
    const maxHabitantes = 50

    override method serOcupadaPor(ejercito){
        if (ejercito.miembros().size > maxHabitantes){

            const nuevosHabitantes = ejercito.miembros().sortedBy{uno otro => 
                uno.potencialOfensivo() > otro.potencialOfensivo()}.take (10)
            
            super(new Ejercito(miembros = nuevosHabitantes))
            ejercito.miembros().removeAll(nuevosHabitantes)
        } else super(ejercito)
    }

}