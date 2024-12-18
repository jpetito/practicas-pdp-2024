%VOCALOID

%canta(vocaloid, cancion(nombre(DuracionMinutos)))

canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(foreverYoung, 4)).
canta(hatsuneMiku, cancion(tellYourWorld, 5)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).


esUnVocaloid(Vocaloid):- canta(Vocaloid, _).
%kaito no lo escribo por principio de universo cerrado, si no lo escribo no canta ninguna cancion.

%PUNTO 1
esNovedoso(Vocaloid):-
    canta(Vocaloid, cancion(Cancion, Duracion)),
    canta(Vocaloid, cancion(OtraCancion, OtraDuracion)),
    Cancion \= OtraCancion,
    Total is Duracion + OtraDuracion,
    Total < 15.

%PUNTO 2
acelerado(Vocaloid):-
    esUnVocaloid(Vocaloid),
%   forall(canta(Vocaloid, cancion(_, Duracion)), Duracion < 4).
    not((canta(Vocaloid, cancion(_, Duracion)), not(Duracion < 4))).

%PUNTO 1

%concierto(Nombre, Pais, Fama, Tamanio).

%gigante(CantMinimaCanciones, TiempoMinCanciones).
%mediano(TiempoMax).
%pequenio(CantMinimaCanciones, tiempoMax).

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(1, 4)).

%%PUNTO 2
puedeParticipar(hatsuneMiku, Concierto):- concierto(Concierto, _, _, _).

puedeParticipar(Vocaloid, Concierto):- 
    esUnVocaloid(Vocaloid),
    Vocaloid \= hatsunemiku,
    concierto(Concierto, _, _, Requisitos),
    cumpleRequisitos(Vocaloid, Requisitos).

cumpleRequisitos(Vocaloid, gigante(CantMinimaCanciones, TiempoMinCanciones)):-
    cantidadCanciones(Vocaloid, Cant),
    Cant > CantMinimaCanciones,
    duracionTotalCanciones(Vocaloid, Total),
    Total > TiempoMinCanciones.

cumpleRequisitos(Vocaloid, mediano(TiempoMaxCanciones)):-
    duracionTotalCanciones(Vocaloid, Total),
    Total < TiempoMaxCanciones.

cumpleRequisitos(Vocaloid, pequenio(CantMinimaCanciones, TiempoMax)):-
    cantidadCanciones(Vocaloid, CantidadCanciones),
    CantidadCanciones > CantMinimaCanciones,
    duracionTotalCanciones(Vocaloid, Total),
    Total < TiempoMax.

cantidadCanciones(Vocaloid, Cant):-
    findall(Cancion, canta(Vocaloid, Cancion), Canciones),
    length(Canciones, Cant).

duracionTotalCanciones(Vocaloid, Cant):-
    findall(Duracion, (canta(Vocaloid, Cancion), canta(Cancion, Duracion)), DuracionDeCanciones),
    sumlist(DuracionDeCanciones, Cant).

%%PUNTO 3

masFamoso(Vocaloid):-
    esUnVocaloid(Vocaloid),
    nivelFama(Vocaloid, MayorNivel), %CASO BASE, EL QUE MAS NIVEL TIENE
    forall((esUnVocaloid(OtraVocaloid), OtraVocaloid \= Vocaloid, nivelFama(OtraVocaloid, Nivel)), MayorNivel >= Nivel).

nivelFama(Vocaloid, Nivel):-
    esUnVocaloid(Vocaloid),
    findall(Fama, (puedeParticipar(Vocaloid, Concierto), concierto(Concierto, _, Fama, _)), CantidadFama),
    sumlist(CantidadFama, FamaTotal),
    cantidadCanciones(Vocaloid, Cant),
    Nivel is FamaTotal * Cant. 

%%PUNTO 4

conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

conocidosDirectoOIndirecto(Vocaloid, Conocido):- conoce(Vocaloid, Conocido).
conocidosDirectoOIndirecto(Vocaloid, Conocido):- conoce(Vocaloid, OtroConocido), conoce(OtroConocido, Conocido).

participaSolo(Vocaloid, Concierto):-
    puedeParticipar(Vocaloid, Concierto), %predicado inversible
    conocidosDirectoOIndirecto(Vocaloid, Conocido),
    not(puedeParticipar(Conocido, Concierto)).

