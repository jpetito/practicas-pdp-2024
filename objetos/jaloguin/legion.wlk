class Legion{
    var nenes = #{}

    method miembros() = nenes

    method lider() = nenes.max({nene => nene.capacidadDeAsustar()})

    method sumatoriaSusto() = nenes.sum({nene => nene.sumatoriaSusto()})

    method sumatoriaDeCaramelos() = nenes.sum({nene => nene.cantCaramelos()})
    
    method capacidadDeAsustar() = nenes.sum({nene => nene.capacidadDeAsustar()})

    method intentarAsustar(adulto, cant){
        if (adulto.seAsustaCon(self)){
            adulto.darCaramelos(self, cant)
        }else throw new Exception (message = "El adulto no se asusto")
    }

    method recibirCaramelos(cant){
        self.lider().recibirCaramelos(cant)
    }

    method agregar(nene){
        nenes.add(nene)
    }

    method crear(conjuntoDeNenes){
        if(conjuntoDeNenes.size() >= 2){
            conjuntoDeNenes.forEach({nene => self.agregar(nene)})
        }else throw new Exception (message = "Se necesitan al menos dos nenes")
    }    

}