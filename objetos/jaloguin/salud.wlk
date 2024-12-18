import nene.*

object sano{
    method actitudNene(nene) = nene.actitud()

    method efecto(nene, cant) {
        if (cant >= 10){
        nene.empachate()
        }
    }
}

object empachado{

    method actitudNene(nene) = nene.actitud() / 2

    method efecto(nene, cant){
        if (cant >= 10){
            nene.poneteEnCama()
        }
    }

}

object enCama{

    method actitudNene(nene) = 0

    method efecto(nene, cant){
        throw new Exception(message = "No puede comer más caramelos")
    }
}