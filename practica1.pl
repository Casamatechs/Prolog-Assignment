digito(0).
digito(s(X)) :- digito(X).

primerNumero([X|Y]) :- digito(X), parteEntera(Y).

esComa(',').

parteEntera([X|Y]) :- digito(X), parteEntera(Y).
parteEntera([X|Y]) :- esComa(X), numeroDecimal(Y).

numeroDecimal([X|Y]) :- digito(X), numeroDecimal(Y).
numeroDecimal([X]) :- digito(X).
numeroDecimal([]).

ultimoNumero([X|[]], X).
ultimoNumero([_|X], Y) :- ultimoNumero(X,Y).

mayor(s(s(s(s(s(0)))))).
mayor(s(X)) :- mayor(X).

menor(0).
menor(s(0)).
menor(s(s(0))).
menor(s(s(s(0)))).
menor(s(s(s(s(0))))).

numeroRedondeo(',', ParteEntera, ParteDecimal) :- numeroDecimal(ParteEntera), numeroDecimal(ParteDecimal).

%redondear(TipoRedondeo, ParteEnteraOriginal, ParteDecimalOriginal, ParteEnteraRedondeada, ParteDecimalRedondeada).
redondear(redondeoUnidad, EnteroOrig, [Y|_], EnteroRedond,[]) :- ultimoNumero(EnteroOrig,Unidad), mayor(Y), ultimoNumero(EnteroRedond,s(Unidad)).
redondear(redondeoUnidad, EnteroOrig, [Y|_], EnteroRedond,[]) :- ultimoNumero(EnteroOrig,Unidad), menor(Y), ultimoNumero(EnteroRedond,Unidad).
redondear(redondeoDecima, EnteroOrig, [X|[Y|_]], EnteroRedond, [s(X)]) :- mayor(Y), =(EnteroOrig,EnteroRedond).
redondear(redondeoDecima, EnteroOrig, [X|[Y|_]], EnteroRedond, [X]) :- menor(Y), =(EnteroOrig,EnteroRedond).
redondear(redondeoCentesima, EnteroOrig, [X|[Y|[Z|_]]], EnteroRedond, [X|[s(Y)|[]]]) :- mayor(Z), =(EnteroOrig,EnteroRedond).
redondear(redondeoCentesima, EnteroOrig, [X|[Y|[Z|_]]], EnteroRedond, [X|[Y|[]]]) :- menor(Z), =(EnteroOrig,EnteroRedond).




suma(X,0,X).
suma(X,X,0).
suma(s(X),s(Y), Z) :- suma(X,Y,Z).
