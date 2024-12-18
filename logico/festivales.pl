%%Festivales de Rock

% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipódromoSanIsidro).
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipódromoDePalermo).
festival(primaveraSound, [articMonkeys, clairo], parqueSarmiento).
festival(acaasdas, [articMonkeys, clairo], parqueSarmiento)
% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipódromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipódromoSanIsidro, zona1, 1500).

%%1.
itinerante(Festival):-
    festival(Festival, Bandas, Lugar),
    festival(Festival, Bandas, OtroLugar),
    Lugar /= OtroLugar.

%%2.
careta(Festival):-
    festival(Festival, _, _),
    not(entradaVendida(Festival, campo)).
careta(personalFest).

%%3. 
nacAndPop(Festival):-
    festival(Festival, Bandas, _),
    not(careta(Festival)),
    forall(member(Banda, Bandas), (banda(Banda, argentina, Popularidad), Popularidad > 1000)).

%%4.
sobrevendido(Festival):-
    festival(Festival, _, Lugar),
    findall(Entrada, entradaVendida(Festival, Entrada), Entradas),
    lenght(Entradas, CantEntradas),
    lugar(Festival, Capacidad, _),
    Capacidad < CantEntradas.

%%5.
recaudacionTotal(Festival, Recaudacion):-
    festival(Festival, _, _)