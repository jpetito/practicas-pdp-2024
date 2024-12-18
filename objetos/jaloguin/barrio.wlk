class Barrio{
    var habitantes = #{}

    method ordenarPorMasCantCaramelos(){
        return habitantes.sortedBy{unNene, otroNene => unNene.cantCaramelos() > otroNene.cantCaramelos()}
    }

    method tresNenesConMasCaramelos(){
       return self.ordenarPorMasCantCaramelos().take(3)
    }

    method nenesConMasDe10Caramelos(){
        return habitantes.filter({nene => nene.cantCaramelos() >= 10})
    }

    method elementosNenes(){
        return self.nenesConMasDe10Caramelos().forEach{nene => nene.elementosPuestos()}
    }
}