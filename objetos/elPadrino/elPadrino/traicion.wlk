class Traicion{
    const traidor
    var victimas = #{}

    var fechaTentativa

    method seAgregaVictima(victima){
        victimas.add(victima)
    }

    method seComplica(dias, victima){
        fechaTentativa -= dias
        self.seAgregaVictima(victima)
    }

    method seAjusticia() = traidor.familia().promedioLealtad() > (2 * traidor.lealtad())

    method seConcreta(nuevaFamilia) {
        if(self.seAjusticia().not()){
            victimas.forAll({victima => traidor.atacar(victima)})
            traidor.cambiarFamilia(nuevaFamilia)
        }
    }

}