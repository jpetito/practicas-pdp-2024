object pepe {

    var neto = 0 
    var bonoResultados = 0 
    var bonoPresentismo = 0 
    var faltas = 0

    method calcularSueldo() { //return
      return neto + bonoResultados + bonoPresentismo 
    }

    method CalcularNeto(categoria) {
        if (categoria == "GERENTES")
            return 15000
        else if(categoria == "CADETES")
            return 20000
        else 
            return 0 
    }

    method calcularBonoResultados(tipoBono) {
        if (tipoBono == "PORCENTAJE") 
            return neto * 0.10
        else if (tipoBono == "MONTO_FIJO") 
            return 800
        else return 0
    }
    
    method calcularBonoPresentismo(tipoBono){
        if (tipoBono == "NORMAL"){
            if(faltas == 0)
                return 2000 
            else if(faltas == 1)
                return 1000
           else
                return 0 
        }
        if (tipoBono == "AJUSTE"){
            if (faltas == 0)
                return 100
            else 
                return 0
        }

        if(tipoBono == "DEMAGOGICO"){
            if(neto < 18000){
                return 500
            }
            else{
                return 300
            }
        }
        else 
            return 0
    }
}

//VARIANTES

object sofia {
    
    var neto = 0 
    var bonoResultados = 0 

    method CalcularNeto(categoria) {
        if (categoria == "GERENTES")
            return 15000 * 1.3 
        else if(categoria == "CADETES")
            return 20000  * 1.3
        else 
            return 0 
    }

    method calcularSueldo() { 
      return neto + bonoResultados 
    }
  
}

object vendedor {
    var neto = 16000

    method activarAumentoPorMuchasVentas(){
        neto = neto * 1.25
    }

    method desactivarAumentoPorMuchasVentas(){
        return neto
    }
}

object carla {
    var neto = 28000
    var bonoResultados = 0
    
    method calcularSueldo() {
      neto = neto + bonoResultados + 9000
    }

    method calcularBonoResultados(tipoBono){
        if (tipoBono == "PORCENTAJE") 
            return neto * 0.10
        else if (tipoBono == "MONTO_FIJO") 
            return 800
        else return 0
    }
}

object oliver{ 
    var companiero = pepe
    var bonoPresentismo = 0
    var neto = 0


    method cambiarCompaniera(nuevaCompaniera) {
		companiero = nuevaCompaniera
	}

    method calcularSueldo() {
      return neto + bonoPresentismo 
    }

    method calcularBonoPresentismo(tipoBono){
        if (tipoBono == "NORMAL")
            return 2000 

        else if (tipoBono == "AJUSTE")
            return 100
            
        else if (tipoBono == "DEMAGOGICO"){
            if(neto < 18000){
                return 500
            }
            else{
                return 300
            }
        }
        else 
            return 0
    }
}