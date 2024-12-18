% Registramos las características de las lechuzas de la zona (nombre, sospechosidad y nobleza) con un predicado lechuza/3.

% lechuza(Lechuza, Sospechosidad, Nobleza)
lechuza(duo, 10, 2).
lechuza(noctowl, 20, 42).
lechuza(prolog, 10, 51).
lechuza(coo, 80, 55).

% Necesitamos saber:
% ¿Qué tan violenta es una lechuza?

% Se calcula como 5 * sospechosidad + 42 / nobleza.
violencia (Lechuza, NiveldeViolencia):-
    lechuza(Lechuza, Sospechosidad, Nobleza),
    NiveldeViolencia is 5 * Sospechosidad + 42 / Nobleza.

% es inversible por lechuza y por nivel. la inversibilidad depende en los predicador del nivel de inversible de los "otros".

% Si una lechuza es vengativa. Lo es si su violencia es mayor a 100.
vengativa (Lechuza):-
    violencia (Lechuza, NiveldeViolencia),
    NiveldeViolencia > 100.

% Si una lechuza es mafiosa, que se cumple si no es buena gente o su sospechosidad es al menos 75. Decimos que es buena gente si no es vengativa y su nobleza es mayor a 50.
mafiosa (Lechuza):-
    lechuza(Lechuza,_,_),
    not (buenaGente(Lechuza)).
mafiosa (Lechuza):-
    lechuza(Lechuza, Sospechosidad, Nobleza),
    Sospechosidad > 75.

buenaGente (Lechuza):-
    lechuza(Lechuza, Sospechosidad, Nobleza),
    not (vengativa(Lechuza)),
    Nobleza > 50.


:- begin_tests(lechuzas).

:- end_tests(lechuzas).
