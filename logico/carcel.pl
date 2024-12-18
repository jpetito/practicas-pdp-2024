%%La cárcel

% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotráfico([metanfetaminas])).
prisionero(alex, narcotráfico([heroína])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
% prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotráfico[heroína, opio])).
prisionero(dayanara, narcotráfico([metanfetaminas])).


% controla(Controlador, Controlado)

controla(piper, alex).
controla(bennett, dayanara).
controla(Guardia, Otro):-
    guardia(Guardia),
    %agrego el guardia para que sea completamente inversible
    prisionero(Otro,_),
    not(controla(Otro, Guardia)).
%%2
conflictoDeIntereses(Persona, OtraPersona):-
    controla(Tercero, Persona),
    controla(Tercero, OtraPersona),
    not(controla(Persona, OtraPersona)),
    not(controla(OtraPersona, Persona)),
    Persona \= OtraPersona.
%%3
peligroso(Prisionero):-
    prisionero(Prisionero, _),
    forall(prisionero(Prisionero, Crimen), esGrave(Crimen)).

esGrave(homicidio(_)).
esGrave(narcotráfico(Drogas)):- lenght(Drogas, Cant), Cant >= 5.
esGrave(narcotráfico(Drogas)):- member(metanfetaminas, Drogas).
%%4
monto(robo(Monto), Monto).

ladronDeGuanteBlanco(Prisionero):-
    prisionero(Prisionero, _),
    not(peligroso(Prisionero)),
    forall(prisionero(Prisionero, Crimen), (monto(Crimen, Monto), Monto >= 100000)).
%%5
condena(Prisionero, AniosTotales):-
    prisionero(Prisionero, _),
    findall(Crimen, (prisionero(Prisionero, Crimen), pena(Crimen, Anio)), Anios),
    sumlist(Anios, AniosTotales).

%%pena(crimen, anio)
pena(robo(Cantidad), Anio):- 
    Anio is (Cantidad / 10000).
pena(homicidio(Asesinado), Anio):-
    prisionero(Asesinado, _),
    Anio is 7.
pena(homicidio(Asesinado), Anio):-
    guardia(Asesinado),
    Anio is 9.
pena(narcotráfico(Drogas), Anio):-
    lenght(Drogas, Cant),
    Anio is Cant * 2.

%%6
%%Se dice que un preso es el capo de todos los capos cuando nadie lo controla,
%% pero todas las personas de la cárcel (guardias o prisioneros) son 
%%controlados por él, o por alguien a quien él controla (directa o 
%%indirectamente).

% controla(Controlador, Controlado)
controlaDirectaOIndirectamente(Preso, Persona):-
    prisionero(Preso,_),
    controla(Preso, Persona).
controlaDirectaOIndirectamente(Preso, Persona):-
    prisionero(Preso,_),
    controla(Preso, Otro),
    controla(Otro, Persona).

capoDiTutiLiCapi(Capo):-
    prisionero(Capo, _),
    not(controla(_, Capo)),
    forall((persona(Persona), Capo /= Persona), controlaDirectaOIndirectamente(Capo, Persona)).

persona(Persona):- prisionero(Persona, _).
persona(Persona):- guardia(Persona).