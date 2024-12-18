import salud.*

class Nene {

    var elementosPuestos = #{}
    var actitud
    var caramelos 
    var property salud = sano

    method actitud() = actitud

    method elementosPuestos() = elementosPuestos

    method capacidadDeAsustar() = self.sumatoriaSusto() * salud.actitudNene(self)

    method sumatoriaSusto() = elementosPuestos.sum({elemento => elemento.susto()})

    method cantCaramelos() = caramelos
    
    method recibirCaramelos(cant){
        caramelos += cant
    } //sos re malo matiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii ;((((((((((((((( pipipipipipipipi

    method intentarAsustar(adulto, cant){
        if (adulto.seAsustaCon(self)){
            adulto.darCaramelos(self, cant)
        }else throw new Exception (message = "El adulto no se asusto")
    }

//////////////////////parte D

    method comerCaramelos(cant){
        if (cant <= caramelos){
            caramelos -= cant
            salud.efecto(self, cant)
        } else {
            throw new Exception (message = "No tiene esa cantidad de caramelos")
        }
    }

    method empachate() {
    	salud = empachado
    }

    method poneteEnCama() {
      	salud = enCama
    }

}

