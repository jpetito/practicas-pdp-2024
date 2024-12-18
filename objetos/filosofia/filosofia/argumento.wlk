import discusion.*
class Argumentos{
    var naturaleza
    const property descripcion

    method esEnriquecedor() = naturaleza.enriquecedoraSegun(self)

}

//naturaleza 

object estoica{

    method enriquecedoraSegun(argumento) = true
}

object moralista{

    method enriquecedoraSegun(argumento) = argumento.descripcion().words()

}

object esceptica{

    method enriquecedoraSegun(argumento) = argumento.descripcion().endsWith("?")

}

object cinica {
  
  method enriquecedoraSegun(argumento) = 1.randomUpTo(100) <= 30 //el 30% es enrriquesedor

}

class NaturalezasCombinadas{
    var naturalezas = #{}

    method enriquecedoraSegun(argumento) = naturalezas.all({naturaleza => naturaleza.enriquecedoraSegun(argumento)})
}