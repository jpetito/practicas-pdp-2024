/*animal(Nombre,Clase, Medio)*/
animal(ballena,mamifero,acuatico).
animal(tiburon,pez,acuatico).
animal(lemur,mamifero,terrestre).
animal(golondrina,ave,aereo).
animal(tarantula,insecto,terrestre).
animal(lechuza,ave,aereo).
animal(orangutan,mamifero,terrestre).
animal(tucan,ave,aereo).
animal(puma,mamifero,terrestre).
animal(abeja,insecto,aereo).
animal(leon,mamifero,terrestre).
animal(lagartija,reptil,terrestre).

/* tiene(Quien, Que, Cuantos)*/
tiene(nico, ballena, 1).
tiene(nico, lemur, 2).
tiene(maiu, lemur, 1).
tiene(maiu, tarantula, 1).
tiene(juanDS, golondrina, 1).
tiene(juanDS, lechuza, 1).
tiene(juanR, tiburon, 2).
tiene(nico, golondrina, 1).
tiene(juanDS, puma, 1).
tiene(maiu, tucan, 1).
tiene(juanR, orangutan,1).
tiene(maiu,leon,2).
tiene(juanDS,lagartija,1).
tiene(feche,tiburon,1).

% criterio
criterio(nico, Animal) :-
    animal(Animal, _, terrestre),
    not(animal(lemur, _ , _)).

criterio(maiu, Animal) :-
    not(animal(Animal, insecto, _)).

criterio(maiu, Animal) :-
    animal(Animal, _, _),
    Animal == abeja.

criterio(juanDS, Animal) :-
    animal(Animal, _, acuatico).

criterio(juanDS, Animal) :-
    animal(Animal, ave,_).

criterio(juanR, Animal) :-
    tiene(juanR, Animal, _).

criterio (feche, Animal) :-
    animal(Animal, _, _),
    Animal == lechuza.

% leGusta/2
leGusta(Animal, persona) :-
    tiene(persona, Animal, _),
    criterio(persona, Animal).

% animalDificil/1: si nadie lo tiene, o bien si una sola persona tiene uno solo.
animalDificil(Animal):- 
    animal(Animal,,),
    not(tiene(Alguien, Animal,)). %si nadie lo tiene 

animalDificil(Animal):- %si una sola persona tiene uno solo
    tiene(Persona, Animal,1),
    not(
        tiene(OtraPersona, Animal, ),
        Persona /= Otrapersona. 
    )
% estaFeliz/1: si le gustan todos los animales que tiene.

estaFeliz(Persona):-
    tiene(Persona,_,_), %ligamos a la persona para que pregunte si ESA PERSONA puntual esta feliz, si no lo ligo a alguien especial lo piensa como todos.
    forall(tiene(Persona,Animal,), leGusta(Persona,Animal)). 

% tieneTodosDe/2: si la persona tiene todos los animales de ese medio o clase.
esDeClasificacion(Animal, Medio):-
    animal(Animal, _, Medio).

esDeClasificacion(Animal, Clase):-
    animal(Animal, Clase, _).

tieneTodosDe(Persona, Clasificacion):-
    esDeClasificacion(Animal, Clasificacion),
    tiene(Persona, _, _),
    forall(tiene(Persona,Animal,_), esdeclasificacion(Animal,Clasificacion)).

tieneTodosDe(Clase, Persona):-
    tiene(Persona, _, _),
    forall(tiene(Persona, Animal, _), animal(Animal,Clase,_)).

tieneTodosDe(Medio, Persona):-
    tiene(Persona, _, _),
    forall(tiene(Persona, Animal, _), animal(Animal,Medio,_)).

% completoLaColeccion/1: si la persona tiene todos los animales.
completoLaColeccion(Persona):-
    tiene(Persona, _,_), %ligo una persona
    forall(animal(Animal, _, _), tiene(Persona, Animal)). %en el antecedente lo que pondria es el animal porque yo quiero que 
    % a -> b (a: todos los animales)(cmo que recorreria cada animal) y en el consecuente lo que haria seria fijarse si ese animal lo tiene la persona.
    % claro en el consecuente pongo tiene(Persona, Animal). y va a fijarse con la persona que tengo y con el animal
    %el animal es variante y la persona es fija.
    %forall: lo que hace es "uno por uno".

% delQueMasTiene/2: si la persona tiene más de este animal que del resto.
delQueMasTiene(Persona, Animal):-
    tiene(Persona, _, _),
    forall(tiene(Persona, OtroAnimal, CantOtro), Animal /= OtroAnimal, Cant > CantidadOtra).

%forall no nos resuelve nada simplemente hace que no sea necesario usar dos not.