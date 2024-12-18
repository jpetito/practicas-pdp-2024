%%VACACIONES

%%PUNTOS 1

% seVaA(Persona, Lugar).

seVaA(dodain, pehuenia).
seVaA(dodain, sanMartinDeLosAndes).
seVaA(dodain, sarmiento).
seVaA(dodain, camarones).
seVaA(dodain, playasDoradas).
seVaA(alf, bariloche).
seVaA(alf, sanMartinDeLosAndes).
seVaA(alf, elBolson).
seVaA(nico, marDelPlata).
seVaA(vale, calafate).
seVaA(vale, elBolson).

seVaA(martu, Lugar):- seVaA(nico, Lugar), seVaA(alf, Lugar).
%%juan y carlos no los pongo por principio de universo cerrado.

%%PUNTO 2

%parqueNacional(nombre).
%cerro(nombre, alturaEnMetros).
%cuerpoDeAgua(nombre, pesca, temperaturaEnGrados).
%playa(nombre, diferenciaMarea).
%excursion(nombre).
%-----------------------------
atraccion(lugar, nombreAtraccion).

atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(travelin)).

atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoDeAgua(moquehue, si, 14)).
atraccion(pehuenia, cuerpoDeAgua(alumine, si, 19)).

vacacionesCopadas(Persona, Lugar):- seVaA(Persona, Lugar), lugarCopado(Lugar).

lugarCopado(Lugar):- atraccion(Lugar, Atraccion), tieneAtraccionCopada(Atraccion).

tieneAtraccionCopada(cerro(_, Altura)):- Altura >= 2000.
tieneAtraccionCopada(cuerpoDeAgua(_, si, _)).
tieneAtraccionCopada(cuerpoDeAgua(_, _, Temperatura)):- Temperatura >= 20.
tieneAtraccionCopada(playa(_, DiferenciaMarea)):- DiferenciaMarea =< 5.
tieneAtraccionCopada(excursion(Excursion)):- length(Excursion, CantidadLetras), CantidadLetras >= 7.
tieneAtraccionCopada(parqueNacional(_)).

%%PUNTO 3.
seCruzaron(Persona, OtraPersona):- 
    seVaA(Persona, Lugar),
    seVaA(OtraPersona, Lugar).

%%PUNTO 4.
costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartinDeLosAndes, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(calafate, 240).
costoDeVida(elBolson, 145).
costoDeVida(marDelPlata, 140).

vacacionesGasoleras(Persona):- 
    seVaA(Persona, _),
    forall((seVaA(Persona, Lugar), costoDeVida(Lugar, Costo)), Costo =< 160).

%%PUNTO 5.
itinerariosPosibles(Persona, Itinerario):-
    seVaA(Persona, _),
    findall(Lugar, seVaA(Persona, Lugar), Lugares),
    permutar(Lugares, Itinerario).

permutar([], []).
permutar(Lista, [Elemento|Permutacion]):-
    select(Elemento, Lista, Resto),
    permutar(Resto, Permutacion).