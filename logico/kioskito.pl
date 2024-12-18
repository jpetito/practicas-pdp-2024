%%Kioskito
%%atiende(Persona, Dia, Desde, Hasta).
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).

atiende(lucas, martes, 10, 20).

atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).

atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).

atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).

atiende(martu, lunes, 23, 24).

%%1
atiende(vale, Dia, Desde, Hasta):-
    atiende(dodain, Dia, Desde, Hasta).
atiende(vale, Dia, Desde, Hasta):-
    atiende(juanC, Dia, Desde, Hasta).
% - nadie hace el mismo horario que leoC
% por principio de universo cerrado, no agregamos a la base de conocimiento aquello que no tiene sentido agregar
% - maiu está pensando si hace el horario de 0 a 8 los martes y miércoles
% por principio de universo cerrado, lo desconocido se presume falso
% 
% En caso de no ser necesario hacer nada, explique qué concepto teórico está relacionado y justifique su respuesta.

%%2.
quienAtiende(Persona, Dia, Hora):-
    atiende(Persona, Dia, Desde, Hasta),
    Hora =< Hasta,
    Hora >= Desde.


%%3.
estaSola(Persona, Dia, Hora):-
    quienAtiende(Persona, Dia, Hora),
    not((quienAtiende(OtraPersona, Dia, Hora), OtraPersona \= Persona)).

%%4.
posibilidadesDeAtencion(Dia, Personas):-
    findall(Persona, atiende(Persona, Dia, _, _), PersonasPosibles),
    combinar(PersonasPosibles, Personas).

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).

%%5.
%%golosinas(valor).
%%cigarrillos(marca).
%%bebidas(alcoholicas, cantidad).

%%ventas(Persona, fecha(dia, mes) ventas)
ventas(dodain, fecha(10, 8), [golosinas(1200), cigarrillos(jockey), golosinas(50)]).
ventas(dodain, fecha(12, 8), [bebidas(true, 8), bebidas(false, 1), golosinas(10)]).
ventas(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, fecha(11, 8), [golosinas(600)]).
venta(lucas, fecha(18, 8), [bebidas(false, 2), cigarrillos([derby])]).

suertuda(Persona):-
    ventas(Persona, _, _),
    forall(ventas(Persona, _ , [PrimeraVenta|_]), ventaImportante(PrimeraVenta)).

ventaImportante(golosinas(Valor)):- Valor >= 100.  
ventaImportante(cigarrillos(Marcas)):- 
    length(Marcas, Cant),
    Cant > 2.
ventaImportante(bebidas(true, _)).
ventaImportante(bebidas(_, Cant)):- Cant > 5.


:-begin_tests(kioskito).

  test(vale_atiende_los_viernes, nondet):-
    atiende(vale, viernes, _, _).

 test(dodain_atiende_los_lunes_a_las_14, set(Persona = [dodain, leoC, vale])):-
     quienAtiende(Persona, lunes, 14).

 test(juanC_atiende_los_sabados_a_las_18, set(Persona = [juanC, vale])):-
     quienAtiende(Persona, sabado, 18).

test(juanFdS_atiende_los_jueves_a_las_11, nondet):-
     quienAtiende(juanFdS, jueves, 11).

test(vale_atiende_los_lunes_a_las_10, set(Dia = [lunes, miercoles, viernes])):-
    quienAtiende(vale, Dia, 10).

test(vale_atiende_los_lunes_a_las_10, set(Dia = [lunes, miercoles, viernes])):-
    quienAtiende(vale, Dia, 10).

test(lucas_esta_solo_el_martes_a_las_19, nondet):-
    estaSola(lucas, martes, 19).
test(juanFdS_esta_solo_el_jueves_a_las_10, nondet):-
    estaSola(juanFdS, jueves, 10).

test(personas_suertudas, set(Persona= [dodain, martu])):-
    suertuda(Persona).