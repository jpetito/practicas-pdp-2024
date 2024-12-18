import actividad.*
class Filosofo{
    const property nombre
    var property edad
    var diasVividos
    var property nivelIluminacion
    var actividades = #{}
    var property honorificos = #{}

    method presentate() = self.nombre() + self.honorificosString()

    method honorificosString() = self.honorificos().join(",") 

    method enLoCorrecto() = self.nivelIluminacion() > 1000 

    method hacerActividad(actividad){
        actividad.efecto(self)
        actividades.add(actividad)
    }

    method disminuirIluminacion(cant){
        nivelIluminacion -= cant
    }

    method aumentarIluminacion(cant){
        nivelIluminacion += cant
    }

    method rejuvenecer(cant){
        diasVividos -= cant
    }

    method envejecer(cant){
        diasVividos += cant
    }

    method agregarHonorifico(honorifico){
        honorificos.add(honorifico)
    }

    method esElCumple() = diasVividos % 365 == 0

    method cumplioAnios(){
        self.aumentarIluminacion(10)
        edad += 1
    }

    method vivirUnDia(){
        self.envejecer(1)
        if(self.esElCumple()){
            self.cumplioAnios()
        }
        if(self.esMayorDeEdad()){
            self.efectoMayorEdad()
        }
    }

    method esMayorDeEdad() = self.edad() == 60

    method efectoMayorEdad(){
        if(self.esMayorDeEdad()){
            self.agregarHonorifico("el sabio")
        }
    }

}

class Contemporaneo inherits Filosofo {

    override method presentate() = "Hola"

    override method nivelIluminacion() = super() * self.coeficienteIlum()

    method coeficienteIlum() {
        if (self.ameAdmirarPaisaje()){
            return 5
        } else return 1
    }

    method ameAdmirarPaisaje() = actividades.contains(admirarPaisaje)
}

object admirarPaisaje{}