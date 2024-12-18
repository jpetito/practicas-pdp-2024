%%MINECRAFT
jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

%%1) JUGANDO CON LOS ITEMS

tieneItem(Jugador, Item):-
    jugador(Jugador, Items, _),
    member(Item, Items).

sePreocupaPorSuSalud(Jugador):-
    jugador(Jugador, Items, _),
    member(Item, Items),
    comestible(Item).

cantidadDeItem(Jugador, Item, Cantidad):-
    jugador(Jugador, Items, _),
    member(Item, Items),
    findall(Item, tieneItem(Jugador, Item), ListaDeEseItem),
    length(ListaDeEseItem, Cantidad).

tieneMasDe(Jugador, Item):-
    jugador(Jugador, _, _),
    cantidadDeItem(Jugador, Item, CantMayor),
    forall((cantidadDeItem(Jugador, OtroItem, Cant), Item \= OtroItem), Cant < CantMayor).

%%2 ALEJARSE DE LA OSCURIDAD
hayMonstruos(Lugar):-
    lugar(Lugar, _, Oscuridad),
    Oscuridad > 6.

%%si se encuentra en un lugar con monstruos.
correPeligro(Jugador):-
    jugador(Jugador, _, _),
    lugar(Lugar, Personas, _),
    member(Jugador, Personas),
    hayMonstruos(Lugar).
%%si esta hambriento y no cuenta con items comestibles
correPeligro(Jugador):-
    estaHambriento(Jugador),
    sePreocupaPorSuSalud(Jugador). %%si tiene algun item comestible

estaHambriento(Jugador):-
    jugador(Jugador, _, NivelDeHambre),
    NivelDeHambre < 4.

nivelPeligrosidad(Lugar, Nivel):-
    hayMonstruos(Lugar),
    Nivel is 100.
nivelPeligrosidad(Lugar, Nivel):-
    not(hayMonstruos(Lugar)),
    porcentajeHambrientos(Lugar, Porcentaje),
    Nivel is Porcentaje.
nivelPeligrosidad(Lugar, Nivel):-
    not(estaPoblado(Lugar)),
    lugar(Lugar, _, Oscuridad),
    Nivel is Oscuridad * 10.

porcentajeHambrientos(Lugar, Porcentaje):-
    lugar(Lugar, Personas, _),
    length(Personas, CantDePersonas), %% seria el 100%
    findall(Persona, (member(Persona, Personas), estaHambriento(Persona)), PersonasHambrientas),
    length(PersonasHambrientas, CantDeHambrientos),
    Porcentaje is ((CantDeHambrientos * 100) / CantDePersonas). %%saco el porcentaje de hambientos.
estaPoblado(Lugar):-
    lugar(Lugar, Personas, _),
    length(Personas, CantDePersonas),
    CantDePersonas \= 0.   

%%A CONSTRUIR
%%item(Nombre, ItemsParaConstruirlo).
%%itemSimbre(Materias, Cant).
%%itemCompuesto(unicaUnidad).

item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).


puedeConstruir(Jugador, Item):- 
    jugador(Jugador, _, _),
    item(Item, ItemsNecesarios),
    forall((member(ItemNecesario, ItemsNecesarios)), tieneItemSimpleOCompuesto(Jugador, ItemNecesario)).

tieneItemSimpleOCompuesto(Jugador, itemSimple(Nombre, Cant)):- %% Si es simple
    jugador(Jugador, _, _),
    cantidadDeItem(Jugador, Nombre, CantJugador),
    CantJugador >= Cant. 

tieneItemSimpleOCompuesto(Jugador, itemCompuesto(Nombre)):- %%Si es complejo
    jugador(Jugador, _, _),
    item(Nombre, ItemsNecesarios),
    forall(member(Item, ItemsNecesarios), tieneItemSimpleOCompuesto(Jugador, Item)).

