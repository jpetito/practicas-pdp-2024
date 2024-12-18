import evento.*
import empleados.*

class LenguajeProgramacion{
    const anioCreacion

    method esAntiguo() = self.aniosDesdeCreacion() > 30

    method esModerno() = self.aniosDesdeCreacion() < 10

    method aniosDesdeCreacion() = new Date().year() - anioCreacion
}

