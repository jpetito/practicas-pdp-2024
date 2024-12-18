object tomarVino {
  
    method efecto(filosofo){
        filosofo.disminuirIluminacion(10)
        filosofo.agregarHonorifico("el borracho")
    }
}

class JuntarseEnElAgora{
    const compania

    method efecto(filosofo) {
        filosofo.aumentarIluminacion(compania.nivelIluminacion() / 10)
    }
}

class MeditarBajoCascada{
    const altura

    method efecto(filosofo){
        filosofo.aumentarIluminacion(altura*10)
    }
}

class PracticarDeporte{
    var deporte

    method efecto(filosofo) {
        filosofo.rejuvenecer(deporte.dias())
    }

}

//deportes 
object futbol { 
    method diasRejuvenecimiento() = 1
}
object polo {
    method diasRejuvenecimiento() = 2
}
object waterpolo {
    method diasRejuvenecimiento() = polo.diasRejuvenecimiento() * 2
}
