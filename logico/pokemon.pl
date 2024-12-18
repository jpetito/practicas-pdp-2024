%%Pokemon
%%pokemon(Nombre, Tipo).
pokemon(pikachu, electrico).
pokemon(charizard, fuego).
pokemon(venusaur, planta).
pokemon(blastoise, agua).
pokemon(snorlax, normal).
pokemon(rayquaza, dragon).
pokemon(rayquaza, volador).

%entrenador(Nombre, Pokemones).
entrenador(ash, [pikachu, charizard]).
entrenador(brock, [snorlax]).
entrenador(misty, [blastoise, venusaur, arceus]).

%%1.
esTipoMultiple(Pokemon):-
    pokemon(Pokemon, Tipo),
    pokemon(Pokemon, OtroTipo),
    Tipo \= OtroTipo.
%%2.
esLegendario(Pokemon):-
    esTipoMultiple(Pokemon),
    entrenador(_, Pokemones),
    not(member(Pokemon, Pokemones)).
%%3.
esMisterioso(Pokemon):-
    pokemon(Pokemon, Tipo),
    forall((pokemon(OtroPokemon, OtroTipo), OtroPokemon \= Pokemon), Tipo \= OtroTipo).
esMisterioso(Pokemon):-
    pokemon(Pokemon, _),
    entrenador(_, Pokemones),
    not(member(Pokemon, Pokemones)).    
%%MOVIMIENTOS
% ataques(nombrePOkemon, Movimiento).
% fisico(nombre, Potencia).
% especial(nombre, Potencia, Tipo).
% defensivo(Nombre, Reduccion).

ataques(pikachu, fisico(mordedura, 95)).
ataques(pikachu, especial(impactrueno, electrico, 40)).
ataques(charizard, especial(garraDragon, dragon, 100)).
ataques(charizard, fisico(mordedura, 95)).
ataques(charizard, fisico(mordedura, 95)).
ataques(blastoise, proteccion(defensivo, 10)).
ataques(blastoise, fisico(placaje, 50)).
ataques(arceus, defensivo(proteccion, 10)).
ataques(arceus, especial(impactrueno, electrico, 40)).
ataques(arceus, especial(garraDragon, dragon, 100)).
ataques(arceus, fisico(placaje, 50)).
ataques(arceus, defensivo(alivio, 100)).

%%1.

esBasico(fuego).
esBasico(agua).
esBasico(planta).
esBasico(normal).

danioAtaque(fisico(_, Danio), Danio).  
danioAtaque(defensivo(_, _), 0).
danioAtaque(especial(_, Potencia, esBasico), Danio):- Danio is Potencia * 1.5.
danioAtaque(especial(_, Potencia, dragon), Danio):- Danio is Potencia * 3.
danioAtaque(especial(_, Potencia, Tipo), Danio):- 
    not(esBasico(Tipo)),
    Tipo \= dragon,
    Danio is Potencia * 1.

%%2.

capacidadOfensiva(Pokemon, Capacidad):-
    ataque(Pokemon, _),
    findall(Danio, (ataque(Pokemon, Ataque), danioAtaque(Ataque, Danio)), DanioPorAtaque),
    sumlist(DanioPorAtaque, Capacidad).

%%3.
picante(Entrenador):-
    entrenador(Entrenador, Pokemones),
    forall(member(Pokemon, Pokemones), esMisterioso(Pokemon)).
picante(Entrenador):-
    entrenador(Entrenador, Pokemones),
    forall(member(Pokemon, Pokemones), (capacidadOfensiva(Pokemon, Capacidad), Capacidad > 200)).