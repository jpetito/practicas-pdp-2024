class Persona{
    var edad
    var sueniosPendientes = #{}
    var sueniosCumplidos = #{}
    var carreras = #{}
    var lugares = #{}
    var plataDeseada = #{}
    var tieneHijos = false
    var felicidad
    //punto 3
    var personalidad //realista, obsesivo, alocado etc etc

    method cumplirSuenioElegido() {
        const suenioElegido = personalidad.elegirSuenio(sueniosPendientes)
        suenioElegido.cumplirse(self)
    }

    method cumplio(suenio){
        sueniosCumplidos.add(suenio)
        sueniosPendientes.remove(suenio)
        suenio.efecto(self)
    }

    method sumarFelicidad(cant) {
        felicidad += cant
    }

    method quiereEstudiar(carrera) = carreras.contains(carrera)

    method yaLoCumplio(suenio) = sueniosCumplidos.contains(suenio)
    
    method esSufientePlata(plata) = plata >= plataDeseada 

    method quiereViajarA(lugar) = lugares.contains(lugar)

    method seRecibio(carrera){
        carreras.remove(carrera)
    }

    method adoptoUnHijo(){
        tieneHijos = true
    }

    method yaViajoA(lugar) {
        lugares.remove(lugar)
    }

    method esFeliz() = self.felicidadDeLosSueniosPendientes() < felicidad

    method felicidadDeLosSueniosPendientes() = sueniosPendientes.sum({suenio => suenio.felicidad()})

    method sueniosTotales() = sueniosCumplidos.union(sueniosPendientes)

    method sueniosAmbiciosos() = self.sueniosTotales().filter({suenio => suenio.esAmbicioso()})

    method esAmbiciosa() = self.sueniosAmbiciosos().size() > 3
}

object realista { 
	method elegirSuenio(sueniosPendientes) {
       return sueniosPendientes.max({suenio => suenio.felicidad()})
	}
}

object alocado { 
	method elegirSuenio(sueniosPendientes) {
		return sueniosPendientes.anyOne()
	}
}

object obsesivo { 
	method elegirSuenio(sueniosPendientes) {
		return sueniosPendientes.first()
	}
}