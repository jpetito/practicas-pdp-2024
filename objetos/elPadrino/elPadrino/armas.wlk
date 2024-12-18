class Arma{
    var balas

    method puedeDisparar() = balas > 0

    method disparo(persona){
        self.puedeDisparar()
        balas = (balas - 1).max(0)
    }

    method esSutil()
}

class Revolver inherits Arma{

    override method disparo(persona){
        persona.morir()
        super(persona)
    }

    override method esSutil() = balas == 1

}

class Escopeta inherits Arma{

    override method disparo(persona){
        persona.herir()
        super(persona)
    }

    override method esSutil() = false
}

class CuerdaDePiano inherits Arma{
    const esBuenaCalidad = true

    override method disparo(persona){
        if(esBuenaCalidad){
            persona.morir()
        }else persona.herir()
        super(persona)
    }

    override method esSutil() = true
}