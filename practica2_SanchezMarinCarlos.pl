% No hace falta predicado cierre ya que se van a emplear elementos atómicos. Hay que sacar los extremos no unificados de una cadena.
conexionEslabon(eslabon(A,B),eslabon(A,C),[B,C]).
conexionEslabon(eslabon(A,B),eslabon(C,A),[B,C]).
conexionEslabon(eslabon(B,A),eslabon(A,C),[B,C]).
conexionEslabon(eslabon(B,A),eslabon(C,A),[B,C]).

contiene(eslabon(_,Elem),Elem).
contiene(eslabon(Elem,_),Elem).

extremosIguales(Cadena) :-
        arg(1,Cadena,Eslabon1),
        arg(2,Cadena,[Eslabon2|_]),
        conexionEslabon(Eslabon1,Eslabon2,[A,_]),
        length(Cadena,Length), last(Cadena,Eslabon4),
        getNElem(Cadena,Length-1,Eslabon3),
        conexionEslabon(Eslabon3,Eslabon4,[_,B]),
        A = B.

% Se empieza desde 1 ya que Prolog suele hacerlo así, y es mejor no mezclar. Anyway, an array always start on 0.
getNElem([A|_],1,A).
getNElem([_|C],N,Elem) :- N > 1, %Añadido para evitar recursion infinita, igual no hace falta en un futuro.
        N1 is N-1,
        getNElem(C,N1,Elem).

sacarCombs(Lista,3,Comb) :-
        comb(3,Lista,Comb);
        N1 is 4,
        sacarCombs(Lista,N1,Comb).

sacarCombs(Lista,N,Comb) :-
        N > 3,
        length(Lista,N1),
        N =< N1,
        comb(N,Lista,Comb);
        N > 3,
        N2 is N+1,
        length(Lista,N1),
        N2 =< N1,
        sacarCombs(Lista,N2,Comb).

comb(0,_,[]).
comb(N,[X|T],[X|Comb]):-
        N>0,N1 is N-1,
        comb(N1,T,Comb).
comb(N,[_|T],Comb):-
        N>0,
        comb(N,T,Comb).

perm([],[]).
perm(List,[H|Perm]):- borrar(H,List,Rest),perm(Rest,Perm).

borrar(X,[X|T],T).
borrar(X,[H|T],[H|NT]):- borrar(X,T,NT).

getEslabones([E1|[E2|[E3|_]]],E1,E2,E3).

esCadena([_|[]],Cadena,0) :- extremosIguales(Cadena).
esCadena([E1|[E2|[]]],Cadena,1) :- conexionEslabon(E1,E2,_), esCadena([E2],Cadena,0).
esCadena(Lista,Cadena,N) :-
        N > 1,
        getEslabones(Lista,E1,E2,E3),
        conexionEslabon(E1,E2,[_,ELibre]),
        contiene(E3,ELibre),
        arg(2,Lista,NoHead),
        N1 is N-1,
        esCadena(NoHead,Cadena,N1).

cierreMinimo(Lista,N) :-
        N1 is 3,
        sacarCombs(Lista,N1,Comb),
        perm(Comb,Perm),
        length(Perm,N),
        N2 is N-1,
        esCadena(Perm,Perm,N2),
        !.

cierre(Lista,Cierre) :-
        N is 3,
        sacarCombs(Lista,N,Comb),
        perm(Comb,Perm),
        length(Perm,N1),
        N2 is N1-1,
        esCadena(Perm,Perm,N2),
        Perm = Cierre.