%%ToyStory

%duenio(duenio, juguete, anios).
duenio(andy, woody, 8).
duenio(sam, jessie, 3).

%deTrapo(tematica)
%deAccion(tematica, partes)
%miniFiguras(tematica, cantDeFiguras)
%caraDePapa(partes)

juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(señorCaraDePapa, caraDePapa([original(pieIzquierdo), original(pieDerecho), repuesto(nariz)])). 

esRaro(deAccion(stacyMalibu, 1, [sombrero])).
esColeccionista(sam).

%%1.a)
tematica(Juguete, Tematica):- juguete(Juguete, deTrapo(Tematica)).
tematica(Juguete, Tematica):- juguete(Juguete, deAccion(Tematica, _)).
tematica(Juguete, Tematica):- juguete(Juguete, miniFiguras(Tematica, _)).
tematica(señorCaraDePapa, caraDePapa).
%%1.b)
esDePlastico(Juguete):- juguete(Juguete, miniFiguras(_,_)).
esDePlastico(Juguete):- juguete(Juguete, caraDePapa(_)).
%%1.c)
esColeccion(Juguete):-
    juguete(Juguete, deAccion(_,_)),
    esRaro(Juguete).
esColeccion(señorCaraDePapa):- esRaro(señorCaraDePapa).
esColeccion(Juguete):- juguete(Juguete, deTrapo(_)).
%%2. 
amigoFiel(Duenio, Juguete):-
    duenio(Duenio, Juguete, Anio),
    not(esDePlastico(Juguete)),
    forall(duenio(Duenio, OtroJuguete, OtroAnio), Anio > OtroAnio).
%%3.
superValioso(Valiosos):-
    findall(Juguete, (juguete(Juguete, Tipo), partes(Tipo, Partes), forall(Partes, member(original(_), Partes)), not(posesionColeccionista(Juguete))), Valiosos).

posesionColeccionista(Juguete):-
    esColeccionista(Duenio),
    duenio(Duenio, Juguete, _).

partes(deAccion, Partes):- juguete(_, deAccion(_, Partes)).
partes(caraDePapa, Partes):- juguete(_, caraDePapa(Partes)).

%%4.
duoDinamico(Duenio, Juguete, OtroJuguete):-
    duenio(Duenio, Juguete, _),
    duenio(Duenio, OtroJuguete, _),
    Juguete /= OtroJuguete,
    buenaPareja(Juguete, OtroJuguete).

buenaPareja(Juguete, OtroJuguete):- 
    tematica(Juguete, Tematica),
    tematica(OtroJuguete, Tematica).
buenaPareja(woody, buzz).

%%5. Relaciona un dueño con la cantidad de felicidad que le otorgan
%todos sus juguetes: 
felicidad(Duenio, CantidadTotal):-
    duenio(Duenio, _ , _),
    findall(Cantidad, (duenio(Duenio, Juguete , _), felicidadDeUnJuguete(Juguete, Cantidad)), CantFelicidad),
    sumlist(CantFeliciad, CantidadTotal).

%FELICIDAD POR JUGUETES DE MANERA INDIVIDUAL
%%Para las minifiguras
felicidadDeUnJuguete(Juguete, Cantidad):-
    juguete(Juguete, miniFiguras(_, CantDeFiguras)),
    CantDeFiguras * 20.
%%Para CaraDePapa
felicidadDeUnJuguete(Juguete, Cantidad):-
    juguete(Juguete, caraDePapa(_)),
    findall(Cant,(juguete(Juguete, caraDePapa(Partes)), member(Parte, Partes), felicidadPorPartes(Parte, Cant)), CantPorPartes),
    sumlist(CantPorPartes, Cantidad).
felicidadPorPartes(original(_), 5).
felicidadPorPartes(repuesto(_), 8).
%%Para los trapo
felicidadDeUnJuguete(Juguete, 100):- juguete(Juguete, deTrapo(_)).
%%Para los de accion
felicidadDeUnJuguete(Juguete, 120):-
    juguete(Juguete, deAccion(_,_)),
    esColeccion(Juguete),
    duenio(Duenio, Juguete, _),
    esColeccionista(Duenio).
felicidadDeUnJuguete(Juguete, 100):-
    juguete(Juguete, deAccion(_,_)),
    not(esColeccion(Juguete),
    duenio(Duenio, Juguete, _),
    esColeccionista(Duenio)).
%%6.
puedeJugarCon(Duenio, Juguete):-
    duenio(Duenio, Juguete, _).
puedeJugarCon(Duenio, Juguete):-
    duenio(OtroDuenio, Juguete),
    puedePrestarselo(OtroDuenio, Duenio).

puedePrestarselo(Duenio, OtroDuenio):-
    duenio(Duenio, _, _),
    duenio(OtroDuenio, _, _),
    cantidadDeJuguetes(Duenio, Cant1),
    cantidadDeJuguetes(OtroDuenio, Cant2),
    Cant1 > Cant2.

cantidadDeJuguetes(Duenio, Cant):-
    duenio(Duenio, _, _),
    findall(Juguete, duenio(Duenio, Juguete, _), Juguetes),
    lenght(Juguetes, Cant).

%%7. NO ENTENDI ESTE PUNTO
podriaDonar(Duenio, JuguetesPropios, CantidadFelicidad):-
    felicidad(Duenio, Felicidad),
    Felicidad > CantidadFelicidad.


