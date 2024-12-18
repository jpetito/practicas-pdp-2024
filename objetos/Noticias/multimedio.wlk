import periodistas.*
import noticia.*

object multimedio{
    const periodistas = #{}
    var noticiasPublicadas = #{}

    method publicarNoticia(noticia, periodista){
        if(self.puedePublicarNoticia(noticia, periodista)){
            noticiasPublicadas.add(noticia) && periodista.publico(noticia)
        }
    }

    method puedePublicarNoticia(noticia, periodista){
        if(periodista.puedePublicar(noticia).not()){
            throw new Exception(message = "El periodista no puede publicar esta noticia")
        } else if (noticia.estaBienEscrita().not()){
            throw new Exception(message = "Esta noticia esta mal escrita")
        } else return true
    }

    method noticiasPublicadasEstaSemana() = noticiasPublicadas.filter({noticia => noticia.sePublicoEstaSemana()})

    method RecientesQuePublicaronEstaSemana() = 
        self.periodistasRecientes().filter({periodista => periodista.publicoAlguna(self.noticiasPublicadasEstaSemana())})

    method periodistasRecientes() = periodistas.filter({periodista => periodista.esReciente()})
}