% No hace falta predicado cierre ya que se van a emplear elementos atómicos. Hay que sacar los extremos no unificados de una cadena.
conexionEslabon(eslabon(A,B),eslabon(A,C),[B,C]).
conexionEslabon(eslabon(A,B),eslabon(C,A),[B,C]).
conexionEslabon(eslabon(B,A),eslabon(A,C),[B,C]).
conexionEslabon(eslabon(B,A),eslabon(C,A),[B,C]).

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
