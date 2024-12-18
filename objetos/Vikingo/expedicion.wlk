class Expedicion{
    var lugaresInvolucrados = #{}
    var vikingos = #{}

    method cantidadVikingos() = vikingos.size()

    method valeLaPena() = lugaresInvolucrados.all({lugar => lugar.valeLaPena(self.cantidadVikingos())})

    method sumarVikingo(vikingo) = vikingos.add(vikingo)

    method realizar(){
        lugaresInvolucrados.forEach({lugar => lugar.invadir(vikingos)})
    }
}

 

class Lugar{

    method valeLaPena(vikingos)

    method botin(cantVikingos)

    method invadir(vikingos){
        self.repartirBotin(vikingos)
    }

    method repartirBotin(vikingos){
        const cantOro = self.botin(vikingos) / vikingos
        vikingos.forEach({vikingo => vikingo.sumarOro(cantOro)})
    }
}

class Capital inherits Lugar{
    var defensores = #{}
    var riqueza

    override method valeLaPena(cantVikingos) = cantVikingos <= self.botin(cantVikingos) / 3

    override method botin(cantVikingos) = self.defensoresDerrotados(cantVikingos) * riqueza

    method defensoresDerrotados(cantVikingos) = defensores.min(cantVikingos)
}

class Aldea inherits Lugar{
    var crucifijos

    override method valeLaPena(cantVikingos) = self.botin(cantVikingos) >= 15

    override method botin(cantVikingos) = crucifijos
}

class Amuralladas inherits Aldea{
    var cantMinimaVikingos

    override method valeLaPena(cantVikingos) = cantVikingos >= cantMinimaVikingos && super(cantVikingos)
}