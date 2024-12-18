import lenguaje.*
import empleados.*

class Evento {
    var property invitados = #{}
    var invitadosPresentes = #{} //lista de asistencia
    var costoFijoSalon = 200000

    method invitar(persona) {
        if (persona.puedeSerInvitado()){
        self.agregarGente(persona)
        }
    }

    method agregarGente(invitado) {
        invitados.add(invitado)
    }

    method registrarAsistencia(invitado){
        invitadosPresentes.add(invitado)
    }

    method llego(invitado)= invitadosPresentes.contains(invitado)

    method cantPersonasAsistidas() = invitadosPresentes.size()

    method costoPorPersonas() = self.cantPersonasAsistidas() * 5000

    method estaInvitado(empleado) = invitados.contains(empleado) 

    method costoTotal() = self.costoPorPersonas() + costoFijoSalon

    method importeTotalRegalos() {
        return invitadosPresentes.count({invitado => invitado.regaloEfectivo()})
    } 

    method balance() = self.costoTotal() - self.importeTotalRegalos() 

    method asistieronTodos() = invitados.all({invitado => self.llego(invitado)})

    method fueUnExito() {
        return self.balance() > 0 && self.asistieronTodos()
    }

    method listaInvitados() = invitados

    method mayorCantDePersonasEnLaMesa(){
        return self.mesas().max { mesa => self.mesas().occurrencesOf(mesa) }
    } 

    method mesas(){
        return invitadosPresentes.map({invitado => invitado.mesa()}) //lista de mesas 
    }

}
