import lenguaje.*
import evento.*

class Personal {
    var lenguajesQueSepan = #{}

    method puedeSerInvitado() 

    method sabeAlgunLenguajeAntiguo() = lenguajesQueSepan.any({lenguaje => lenguaje.esAntiguo()})

    method sabeAlgunLenguajeModerno() = lenguajesQueSepan.any({lenguaje => lenguaje.esModerno()})

    method cantLenguajesModernos() = lenguajesQueSepan.count({lenguaje => lenguaje.esModerno()})

    method cantLenguajesAprendidos() = lenguajesQueSepan.size()

    method aprenderLenguaje(lenguaje) {
        lenguajesQueSepan.add(lenguaje)
    }

    method aprendioLenguaje(lenguaje) = lenguajesQueSepan.contains(lenguaje)

    /////////////////////////////////////////////////////////////////////////////////////////////////

    method asistir(evento){
    if (evento.estaInvitado(self)){
            evento.registrarAsistencia(self)
        }else throw new Exception(message = "No esta en la lista de invitados")
    }

    method mesa() = self.cantLenguajesModernos()

    method regaloEfectivo() = self.cantLenguajesModernos() * 1000

    method seRie(){
        //implementa la risa
    }

}

const wololo = new LenguajeProgramacion(anioCreacion = 2016)

class Desarrollador inherits Personal {

    override method puedeSerInvitado() = self.sabeAlgunLenguajeAntiguo() || self.aprendioLenguaje(wololo)

    method esCopado() = self.sabeAlgunLenguajeAntiguo() && self.sabeAlgunLenguajeModerno()

}

class Infraestructura inherits Personal{
    var experiencia

    override method puedeSerInvitado() = self.cantLenguajesAprendidos() > 5

    method esCopado() = self.tieneMuchaExperiencia()

    method tieneMuchaExperiencia() = experiencia >= 10

}

class Jefe inherits Personal {
    var empleados = #{}

    override method puedeSerInvitado() = self.sabeAlgunLenguajeAntiguo() && self.tieneGenteCopada()

    method tieneGenteCopada() = empleados.all({empleado => empleado.esCopado()})

    method tomarCargo(empleado){
        empleados.add(empleado)
    }

    method consultarPorEmpleado(empleado) = empleados.contains(empleado)

    method cantEmpleados() = empleados.size()

    override method mesa() = 99

    override method regaloEfectivo() = super() + self.cantEmpleados() * 1000

}



