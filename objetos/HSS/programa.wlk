


class Programa {
    var tematicas = #{}
    var panelistas = #{}
    var emitido = false

    method puedeEmitirse() = self.cantPanelistas() >= 2 && self.mitadDeTematicasInteresantesOMas()

    method cantPanelistas() = panelistas.size()

    method mitadDeTematicasInteresantesOMas() = self.tematicasInteresantes().size() >= tematicas.size() / 2

    method tematicasInteresantes() = tematicas.map({tematica => tematica.esInteresante()})

    method emitirPor(tematica){
        panelistas.forEach({panelista => panelista.emitir(tematica)})
    }

    method emitirTematicas(){
        tematicas.forEach({tematica => self.emitirPor(tematica)})
    }

    method emitirPrograma(){
        self.emitirTematicas()
        self.finalizar()
    }

    method finalizar(){
        emitido = true
    }

    method panelistaEstrella(){
        if(emitido){
            panelistas.max({panelista => panelista.puntos()})
        } else throw new Exception(message = "El programa no fue emitido")
    }
}