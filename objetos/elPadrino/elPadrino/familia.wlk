import armas.*
import rangos.*
class Integrante{
    const armas = #{}
    var estaVivo = false
    var estaHerido = false
    var rango
    var property lealtad
    var property familia

    method morir() {
        estaVivo = false 
    }

    method herir(){
        if(estaHerido){
            self.morir()
        }else estaHerido = true
    }

    method durmiendoConLosPeces() = estaVivo.not()

    method cantidadArmas() = armas.size()

    method darArma(arma) = armas.add(arma) 

    method sabeDespacharElegantemente() = rango.despachaElegantemente()

    method atacarFamilia(familiaAtacada){
        const masMafioso = familiaAtacada.masMafioso()

        if(masMafioso.estaVivo()){
            rango.atacar(self, masMafioso)
        }
    }

    method esSoldado() = rango.esSoldado()

    method cambiarFamilia(nueva) {
        familia = nueva
    }

    method subirRangoSoldados(){
        if (self.esSoldado() && self.cantidadArmas() > 5){
            rango = new Subjefe()
        }
    }

    method aumentarLealtad(){
        lealtad += lealtad * 0.1
    }

    method cambiarADon(donAnterior){
        const subordinadosDelDonAnterior = donAnterior.subordinados()

        rango = new Don(subordinados = subordinadosDelDonAnterior)
    }

    method atacar(atacado){
        rango.atacar(self, atacado)
    }
}

class Familia{
    const integrantes = #{}
    var don
    var traiciones = #{}

    method integrantesVivos() = integrantes.filter({integrante => integrante.estaVivo()})

    method soldadosVivos() = self.integrantesVivos().filter({integrante => integrante.esSoldado()})

    method masMafioso() = self.integrantesVivos().max({integrante => integrante.cantidadArmas()})

    method armar() = self.integrantesVivos().forAll({integrante => integrante.darArma(new Revolver(balas = 6))})
    
    method ataqueSopresa(familiaAtacada) {
        self.integrantesVivos().forEach({integrante => integrante.atacarFamilia(familiaAtacada)})
    }

    method aumentarLealtadFamilia(){
        self.integrantesVivos().forEach({integrante => integrante.aumentarLealtad()})
    }

    method reorganizarse(){
        self.soldadosVivos().forEach({integrante => integrante.subirRangoSoldados()})
        self.cambiarDon()
        self.aumentarLealtadFamilia()
    }

    method cambiarDon(){
        const nuevoDon = don.subordinadoMasLeal()
        if (nuevoDon.despachaElegantemente()){
            nuevoDon.cambiarADon(don)
            don = nuevoDon
        }
    }
    method totalLealtad() = self.integrantesVivos().sum({integrante => integrante.lealtad()})

    method totalVivos() = self.integrantesVivos().size()

    method promedioLealtad() = self.totalLealtad() / self.totalVivos()

    
}

