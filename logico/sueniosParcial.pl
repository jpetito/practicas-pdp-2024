%%Suenios

%PUNTO 1

%%hechos
cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).

%suenio(nombreDelSuenio, suenio).
%cantante(cantDiscos).
%futbolista(equipo).
%ganarLoteria(numerosApostados).

%%predicados
suenio(gabriel, ganarLoteria([5,9])).
suenio(gabriel, futbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(macarena, cantante(10000)).
%%no creo un predicado sobre que macarena no quiere ganar la loteria por principio de universo cerrado, si no lo menciono es porque no lo quiere.

%PUNTO 2
esAmbiciosa(Persona):-
    suenio(Persona, _),
    findall(Dificultad, (suenio(Persona, Suenio), dificultad(Suenio, Dificultad)), ListaDificultades),
    sumlist(ListaDificultades, TotalDificultades),
    TotalDificultades >= 20.

dificultad(cantante(CantDiscos), Dificultad):- 
    CantDiscos >= 500000,
    Dificultad is 6.
dificultad(cantante(CantDiscos), Dificultad):- 
    CantDiscos < 500000,
    Dificultad is 4.
dificultad(ganarLoteria(NrosApostados), Dificultad):-
    length(NrosApostados, CantNros),
    Dificultad is 10 * CantNros.
dificultad(futbolista(Equipo), Dificultad):-
    esChico(Equipo),
    Dificultad is 3.
dificultad(futbolista(Equipo), Dificultad):-
    not(esChico(Equipo)),
    Dificultad is 16.

esChico(arsenal). %hechos
esChico(aldosivi).

%PUNTO 3

tieneQuimica(Persona, Personaje):-
    cree(Persona, Personaje),
    quimica(Persona, Personaje).

quimica(Persona, campanita):-
    suenio(Persona, Suenio),
    dificultad(Suenio, Dificultad),
    Dificultad =< 5.

quimica(Persona, Personaje):-
    cree(Persona, Personaje),
    Personaje \= campanita,
    forall((suenio(Persona, Suenio), not(esAmbiciosa(Persona))), esPuro(Suenio)).

esPuro(futbolista(_)).
esPuro(cantante(CantDiscos)):- CantDiscos =< 200000.

%PUNTO 4
esAmigo(campanita, reyesMagos).
esAmigo(campanita, conejoDePascua).
esAmigo(conejoDePascua, cavenaghi).

puedeAlegrar(Personaje, Persona):-
    cree(Persona, Personaje),
    suenio(Persona, _).
puedeAlegrar(Personaje, Persona):-
    tieneQuimica(Persona, Personaje),
    not(estaEnfermo(Personaje)).
puedeAlegrar(Personaje, Persona):-
    tieneQuimica(Persona, Personaje),
    backup(Personaje),
    not(estaEnfermo(Personaje)).

backup(Personaje):-
    esAmigo(Personaje, OtroPersonaje),
    principal(OtroPersonaje).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

principal(campanita).
principal(reyesMagos).
principal(conejoDePascua).

:-begin_tests(suenios).

%%Punto 1
test(gabiel_cree_en_el_mago_de_oz_campanita_y_cavenaghi, set(Personaje = [campanita, magoDeOz, cavenaghi])):-
    cree(gabriel, Personaje).
test(juan_cree_en_el_conejo_de_pascua, nondet):-
    cree(juan, conejoDePascua).
test(macarena_cree_en_reyes_magos_mago_capria_y_campanita, set(Personaje = [reyesMagos, magoCapria, campanita])):-
    cree(macarena, Personaje).
test(gabriel_quiere_ganar_la_loteria_con_5_y_9, nondet):-
    suenio(gabriel, ganarLoteria([5,9])).
%%Punto 2
test(gabriel_es_una_persona_ambiciosa, nondet):-
    esAmbiciosa(gabriel).
%%Punto 3
test(gabriel_tiene_quimica_con_campanita, nondet):-
    tieneQuimica(gabriel, campanita).
test(macarena_tiene_quimica_con_campanita_reyes_magos_y_mago_capria, set(Personaje= [campanita, reyesMagos, magoCapria])):-
    tieneQuimica(macarena, Personaje).
%%Punto 4
test(mago_capria_puede_alegrar_a_macarena, nondet):-
    puedeAlegrar(magoCapria, macarena).
test(campanita_puede_alegrar_a_macarena, nondet):-
    puedeAlegrar(campanita, macarena).   
