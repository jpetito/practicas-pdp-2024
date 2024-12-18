import noticia.*

class Periodista{
    const fechaIngreso = new Date()
    var noticiasPublicadas = #{}
    var preferencia

    method prefierePublicar(noticia) = preferencia.prefiere(noticia)

    method noPrefierePublicar(noticia) = self.prefierePublicar(noticia).not()

    method noticiasDelDia(fecha) = noticiasPublicadas.filter({noticia => noticia.fechaPublicada() == fecha})

    method cantNoticiasQueNoPrefiereDelDia(fecha) = self.noticiasDelDia(fecha).count({noticia => self.prefierePublicar(noticia).not()}) 

    method puedePublicar(noticia) {
        if (self.noPrefierePublicar(noticia)){
            self.cantNoticiasQueNoPrefiereDelDia(noticia.fechaPublicada()) < 2
        } else true
    }

    method publico(noticia){
        noticiasPublicadas.add(noticia)
    }

    method esReciente() = fechaIngreso >= hoy.minusDay(360) 

    method publicoAlguna(noticias) = noticias.any({noticia => noticiasPublicadas.contains(noticia)})
}

const joseDeZer = new Periodista(preferencia = new publicarNoticiasQueComienzanCon(letra = "T"))

//preferencias

object publicarNoticiasCopadas{

    method prefiere(noticia) = noticia.esCopada()
}

object publicarNoticiasSensacionalistas{

    method prefiere(noticia) = noticia.esSensacional()

}

object publicarNoticiasVagas{

    method prefiere(noticia) = noticia.esChivo() || noticia.tieneDesarolloCorto()
}

object publicarNoticiasQueComienzanCon {
    const letra = "a"

    method prefiere(noticia) = noticia.comienzaCon(letra)
}