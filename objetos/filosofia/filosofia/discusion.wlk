import argumento.*
class Discusion{
    const partido1
    const partido2

    method esBuena() = partido1.esBueno() && partido2.esBueno()



// #{1, 2}.union(#{5, 2})
}

class Partido{
    const filosofo
    var property argumentos = #{}

    method tieneBuenosArgumentos() = argumentos.count({argumento => argumento.esEnriquecedor()}) >= (argumentos.size() / 2)

    method esBueno() = self.tieneBuenosArgumentos() && filosofo.enLoCorrecto()
}