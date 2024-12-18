class Suenio{
    var property felicidad
    
    method esCorrectoPara(persona)

    method puedeCumplirsePara(persona) = self.esCorrectoPara(persona)

    method cumplirse(persona){
        if(self.puedeCumplirsePara(persona)){
            persona.sumarFelicidad(felicidad)
            persona.cumplio(self)
        } else throw new Exception (message = "No puede cumplirse el suenio para esta persona")
    }

    method efecto(persona){
        //no hace nada
    }

    method esAmbicioso() = felicidad > 100
}

class TratarRecibirse inherits Suenio{
    const carrera

    override method esCorrectoPara(persona) = persona.quiereEstudiar(carrera) && persona.yaLoCumplio(self).not()

    override method efecto(persona){
        persona.seRecibio(carrera)
    }
}

class ConseguirTrabajo inherits Suenio{
    const trabajo

    override method esCorrectoPara(persona) = persona.esSufientePlata(trabajo.plataQueSeGana())

}

class Trabajo{
    const property plataQueSeGana
}

class AdoptarHijo inherits Suenio{
    
    override method esCorrectoPara(persona) = persona.tieneHijos().not()

    override method efecto(persona){
        persona.adoptoUnHijo()
    }
}

class Viajar inherits Suenio{
    const lugar

    override method esCorrectoPara(persona) = persona.quiereViajarA(lugar)

    override method efecto(persona){
        persona.yaViajoA(lugar)
    }
}

class Multiple inherits Suenio{
    const suenios = #{}

    override method felicidad() = suenios.sum({suenio => suenio.felicidad()})
     
    override method puedeCumplirsePara(persona) = suenios.all({suenio => suenio.esCorrectoPara(persona)})

    override method cumplirse(persona) {
        suenios.forEach({suenio => suenio.cumplirse(persona)})
    }

    override method efecto(persona){
        suenios.forEach({suenio => suenio.efecto(persona)})
    }
}