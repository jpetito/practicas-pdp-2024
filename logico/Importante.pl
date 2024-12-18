Prolog

%permutar: cambiar de lugar los mismos elementos.

permutar([], []).
permutar(Lista, [Elemento|Permutacion]):-
    select(Elemento, Lista, Resto),
    permutar(Resto, Permutacion).

%combinar: puede mezclar todos, puede estar vacia o tener menos elementos.\

combinar([], []).
combinar([_|Resto], Combinacion):-
    combinar(Resto, Combinacion).
combinar([Elemento|Resto], [Elemento|Combinacion]):-
    combinar(Resto, Combinacion).