
%DUNGEONS & DRAGONS

%P1. AVENTUREROS
%personaje(nombre, clase, caracteristicas, oro).

personaje(rin, mago, [responsable, pacifica], 20).
personaje(atalanta, mago, [fuerte, responsable], 5).
personaje(kelsier, luchador, [noble], 50).
personaje(thorfinn, barbaro, [agresivo, fuerte], 15).

%poseeHechizo(persona, hechizo(potencia))
poseeHechizo(rin, fuego(20)).
poseeHechizo(rin, frio(30)).
poseeHechizo(atalanta, fuego(30)).

camaradas(Aventurero, OtroAventurero):-
    personaje(Aventurero, Clase, _, _),
    personaje(OtroAventurero, Clase, _, _),
    Aventurero \= OtroAventurero.

caracteristicaPopular(Caracteristica, Clase):-
    forall(personaje(_, Clase, Caracteristicas, _), member(Caracteristica, Caracteristicas)).

permisoReal(kelsier).
permisoReal(Aventurero):-
    personaje(Aventurero, _, _, Oro),
    Oro >= 50.

%%P2. MISIONES

% Misiones
% mision(nombre, dificultad).
mision(ayudarACruzarLaCalle, deBarrio).
mision(ayudarACortarLenia, deBarrio).
% mision(escoltaReal(miembroDelReino), dificultad).
mision(escoltaReal(diplomatico), aspirante).
mision(escoltaReal(princesa), heroica).
mision(pesadillaDeLaCueva, heroica).
%mision(rosasHeladas(Lugar)).
mision(rosasHeladas(montes), deBarrio).
mision(rosasHeladas(altasMontanias), aspirante).

%todos la pueden realizar
puedeRealizar(Aventurero, ayudarACruzarLaCalle):-
    personaje(Aventurero, _, _, _).

puedeRealizar(Aventurero, ayudarACortarLenia):-
    tieneCaracteristica(fuerte, Aventurero).

puedeRealizar(Aventurero, escoltaReal(diplomatico)):-
    permisoReal(Aventurero).

puedeRealizar(Aventurero, escoltaReal(princesa)):-
    permisoReal(Aventurero),
    tieneCaracteristica(noble, Aventurero).

puedeRealizar(Aventurero, pesadillaDeLaCueva):-
    tieneCaracteristica(agresivo, Aventurero),
    esDeClase(barbaro, Aventurero).
puedeRealizar(Aventurero, pesadillaDeLaCueva):-
    personaje(Aventurero, _, _, _),
    poseeHechizo(Aventurero, fuego(Potencia)),
    Potencia >= 30.

%%Locacion puede ser montes, altasMontanias
puedeRealizar(Aventurero, rosasHeladas(Locacion)):-
    mision(rosasHeladas(Locacion), _),
    personaje(Aventurero, _, _, Oro),
    Oro >= 20,
    poseeHechizo(Aventurero, frio(Potencia)),
    Potencia >= 20.

tieneCaracteristica(Caracteristica, Aventurero):-
    personaje(Aventurero, _, Caracteristicas, _),
    member(Caracteristica, Caracteristicas).
esDeClase(Clase, Aventurero):-
    personaje(Aventurero, Clase, _, _).

misionFacil(Mision):-
    mision(Mision, _),
    forall(personaje(Aventurero, _, _, _), puedeRealizar(Aventurero, Mision)).

%%RESULTADOS DE LAS MISIONES
intento(kelsier, [pesadillaDeLaCueva, ayudarACortarLenia]).
intento(rin, [rosasHeladas(altasMontanias), escoltaReal(princesa)]).
intento(thorfinn, [pesadillaDeLaCueva]).
intento(atalanta, [ayudarACruzarLaCalle, ayudarACortarLenia]).

%resultadoMisiones(Aventurero, Misiones, resultado)
resultadoMisiones(Aventurero, Mision, exitoso):-
    intento(Aventurero, Misiones),
    member(Mision, Misiones),
    puedeRealizar(Aventurero, Mision).

resultadoMisiones(Aventurero, Mision, fallido):-
    intento(Aventurero, Misiones),
    member(Mision, Misiones),
    not(puedeRealizar(Aventurero, Mision)),
    mision(Mision, aspirante).

resultadoMisiones(Aventurero, Mision, fatal):-
    intento(Aventurero, Misiones),
    member(Mision, Misiones),
    not(puedeRealizar(Aventurero, Mision)),
    mision(Mision, heroica).

% Queremos saber si un aventurero es afortunado,
% lo cual se cumple si cumplió exitosamente todas las misiones que intentó.
afortunado(Aventurero):-
    intento(Aventurero, Misiones),
    forall(member(Mision, Misiones), resultadoMisiones(Aventurero, Mision, exitoso)).

%%RECOMPENSAS
% recompensa(dificultad, oro).
recompensaPorDificultad(deBarrio, 2).
recompensaPorDificultad(aspirante, 15).
recompensaPorDificultad(heroica, 50).

recompensa(Aventurero, 0):- murio(Aventurero).

recompensa(Aventurero, OroTotal):-
    intento(Aventurero, Misiones),
    findall(Oro, (member(Mision, Misiones), resultadoMisiones(Aventurero, Mision, exitoso), oroPorMision(Mision, Oro)), OroPorMision),
    sumlist(OroPorMision, OroTotal).

murio(Aventurero):-
    intento(Aventurero, Misiones),
    member(Mision, Misiones),
    resultadoMisiones(Aventurero, Mision, fatal).

oroPorMision(Mision, Oro):-
    mision(Mision, Dificultad),
    recompensaPorDificultad(Dificultad, Oro).

masRecompensado(Aventurero):-
    personaje(Aventurero, _, _, _),
    recompensa(Aventurero, OroMax), 
    forall((recompensa(OtroAventurero, Oro), Aventurero \= OtroAventurero), OroMax > Oro).

:-begin_tests(dragons).

test(rin_es_camarada_de_atalanta, nondet):-
    camaradas(rin, atalanta).

test(ser_responsable_es_popular_entre_los_magos, nondet):-
    caracteristicaPopular(responsable, mago).
    
test(kelsier_tiene_permiso_real, nondet):-
    permisoReal(kelsier).

test(todos_pueden_realizar_ayudar_a_cruzar_la_calle, set(Aventurero = [rin, atalanta, kelsier, thorfinn])):-
    puedeRealizar(Aventurero, ayudarACruzarLaCalle).
test(atalante_y_thorfinn_pueden_ayudar_a_cortar_lenia, set(Aventurero = [atalanta,thorfinn])):-
    puedeRealizar(Aventurero, ayudarACortarLenia).
test(kelseir_puede_escoltar_a_un_diplomatico, nondet):-
    puedeRealizar(kelsier, escoltaReal(diplomatico)).
test(kelseir_puede_escoltar_a_una_princesa, nondet):-
    puedeRealizar(kelsier, escoltaReal(princesa)).
test(thorfinn_puede_realizar_la_pesadilla_en_la_cueva, nondet):-
    puedeRealizar(thorfinn, pesadillaDeLaCueva).
test(atalanta_puede_realizar_la_pesadilla_en_la_cueva, nondet):-
    puedeRealizar(atalanta, pesadillaDeLaCueva).
test(rin_puede_realizar_las_rosas_heladas, nondet):-
    puedeRealizar(rin, rosasHeladas(altasMontanias)).

test(la_unica_mision_facil_es_cruzar_la_calle, nondet):-
    misionFacil(ayudarACruzarLaCalle).

test(pesadillaDeLaCueva_para_thorfinn_es_exitosa, nondet):-
    resultadoMisiones(thorfinn, pesadillaDeLaCueva, exitoso).
test(pesadillaDeLaCueva_para_kelsier_es_fatal, nondet):-
    resultadoMisiones(kelsier, pesadillaDeLaCueva, fatal).

test(atalanta_y_thorfinn_fueron_afortunados, set(Aventurero = [atalanta, thorfinn])):-
    afortunado(Aventurero).

test(aventureros_que_murieron, set(Aventurero = [kelsier, rin])):-
    murio(Aventurero).

test(thorfinn_recibio_50_de_oro, nondet):-
    recompensa(thorfinn, 50).
test(atalanta_recibio_4_de_oro, nondet):-
    recompensa(atalanta, 4).
