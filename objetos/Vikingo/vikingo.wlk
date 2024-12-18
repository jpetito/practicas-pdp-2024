
class Vikingo{
    var property castaSocial
    var oro = 0

    method subirAExpedicion(expedicion){
        if(self.puedeIrAExpedicion()){
            expedicion.sumarVikingo(self)
        }else throw new Exception(message = "no puede subir a la expedicion")
    }

    method puedeIrAExpedicion() = self.esProductivo() && castaSocial.seLePermiteSubir()

    method esProductivo()

    method ascender() = castaSocial.ascenser(self)

    method tieneArmas() 

    method bonificacion()

    method sumarOro(cant){
        oro += cant
    }
}

class Granjero inherits Vikingo{
    var hectareas
    var cantHijos

    override method esProductivo() = self.puedeAlimentarASusHijos()

    method puedeAlimentarASusHijos() = hectareas / cantHijos >= 2

    override method tieneArmas() = false

    override method bonificacion(){
        cantHijos += 2
        hectareas += 2
    } 
}

class Soldado inherits Vikingo{
    var cantVidasCobradas
    var armas

    override method esProductivo() = cantVidasCobradas >= 20 && self.tieneArmas()

    override method tieneArmas() = armas > 0

    override method bonificacion(){
        armas += 10
    } 

}

///CASTA SOCIAL

object Jarl{ //esclavos

    method seLePermiteSubir(vikingo) = vikingo.tieneArmas().not()

    method ascender(vikingo) { 
        vikingo.castaSocial(Karl)
        vikingo.bonificacion()
    }
}

object Karl{ //media

    method seLePermiteSubir() = true

    method ascender(vikingo) { 
        vikingo.castaSocial(Thrall)
    }
}

object Thrall{ //nobles

    method seLePermiteSubir() = true

    method ascender(vikingo){
        //no pasa nada
    }

}