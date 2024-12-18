import armas.*

class Don {
    const subordinados = #{}

    method subordinados() = subordinados
    
    method atacar(atacante, atacado){
        subordinados.anyOne().atacar(atacado)
    }

    method despachaElegantemente() = true

    method esSoldado() = false

    method subordinadoMasLeal() = subordinados.max({integrante => integrante.lealtad()})

}

class Subjefe{
    const subordinados = #{} 
    const armas = #{}

    method atacar(atacante, atacado){
        armas.anyOne().disparo(atacado)
    }

    method despachaElegantemente() = armas.any({arma => arma.esSutil()})

    method esSoldado() = false

}

const escopetaRegalo = new Escopeta(balas = 10)
class Soldados{
    var armas = #{escopetaRegalo}

    method atacar(atacante, atacado){
        armas.firts().disparo(atacado)
    }
    
    method despachaElegantemente() = armas.any({arma => arma.esSutil()})

    method esSoldado() = true
}

object donVito inherits Don {
  
override method atacar(atacante, atacado){
    super(atacante, atacado)
    super(atacante, atacado)
    }
}