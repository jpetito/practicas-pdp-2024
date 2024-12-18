const hoy = new Date()
class Noticia{
    const property fechaPublicada = new Date()
    const property periodista
    const gradoImportancia
    const titulo
    const desarrolloNoticia

    method esCopada() = self.esImportante() && self.esReciente()

    method esImportante() = gradoImportancia >= 8

    method esReciente() = fechaPublicada >= hoy.minusDays(3)  

    method esSensacional() = titulo.contains("espectacular") || titulo.contains("increible") || titulo.contains("grandioso")

    method esChivo() = false

    method tieneDesarolloCorto() = desarrolloNoticia.words().count() <= 100

    method comienzaCon(letra) = titulo.startsWith(letra)

    method estaBienEscrita() = titulo.words().count() >= 2 && desarrolloNoticia.words().count() > 0 

    method sePublicoEstaSemana() = fechaPublicada >= hoy.minusday(7)

}

class Articulo inherits Noticia{
    const links = #{}
    
    override method esCopada() = self.tieneAlMenos2Links() && super()

    method tieneAlMenos2Links() = links.size() >= 2
}

class Publicidad inherits Noticia{
    const chivos = #{}

    override method esCopada() = self.chivosSuficientementePrecio() && super()

    method chivosSuficientementePrecio() = chivos.all({chivo => chivo.saleMinimo(2000)})

    override method esChivo() = true
}
class Chivos{
    const precio
    var producto

    method saleMinimo(cant) = precio >= cant

}

class Reportaje inherits Noticia{
    const reportado

    override method esCopada() = reportado.size() >= 25 && super()

    override method esSensacional() = self.reportoA("Dibu Martinez") && super()

    method reportoA(alguien) = reportado == alguien
}


class Cobertura{
    const noticias = #{}

    method esCopada() = noticias.all({noticia => noticia.esCopada()})
}