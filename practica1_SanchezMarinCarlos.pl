%%% EJERCICIO 1
numero(0).
numero(s(X)) :- numero(X).

numOriginal([ParteEntera|[','|[ParteDecimal|[]]]]) :- esNumero(ParteEntera), esNumero(ParteDecimal).
numRedondeo(',', ParteEntera, ParteDecimal) :- listaPeano(ParteEntera), listaPeano(ParteDecimal).

esNumero(X) :- numero(X).
esNumero([X|[]]) :- numero(X).
esNumero([X|Y]) :- numero(X), esNumero(Y).

listaPeano([]).
listaPeano([X|Y]) :- numero(X), listaPeano(Y).

esVacio([]).

colaPeano([X|[]],X).
colaPeano([_|X],Y) :- colaPeano(X,Y).

inicio([X],[]) :- numero(X).
inicio([X|Z],[X|W]) :- inicio(Z,W).

primero([X|_],X).
quitarCabeza([_|X],X).

concat([],Xfinal, Xfinal) :- listaPeano(Xfinal).
concat([X|Y],Z, [X|Xfinal]) :- numero(X), concat(Y,Z,Xfinal).

sigueNueve(X,Y,Z) :- igual(X,s(s(s(s(s(s(s(s(s(0)))))))))), quitarCabeza(Y,Y2), igual([s(0)|[0|Y2]],Z).

soloNueve([],[]).
soloNueve(X,[]) :- colaPeano(X,Y), \=(Y,s(s(s(s(s(s(s(s(s(0)))))))))).
soloNueve(X,[s(s(s(s(s(s(s(s(s(0)))))))))|Y]) :- inicio(X,Z), colaPeano(X,XX), igual(XX,s(s(s(s(s(s(s(s(s(0)))))))))), soloNueve(Z,Y).

convertZero([],[]).
convertZero([_|X],[0|Y]) :- convertZero(X,Y).

checkNueves([s(s(s(s(s(s(s(s(s(0)))))))))|[]],[]).
checkNueves([s(s(s(s(s(s(s(s(s(0)))))))))|Y],[]) :- checkNueves(Y,[]).

quitarNueve(X,X,[]).
quitarNueve([X|XX], Y, [X|ZZ]) :- quitarNueve(XX,Y,ZZ).

igual(X,X).

mayor(s(s(s(s(s(0)))))).
mayor(s(X)) :- mayor(X).

menor(0).
menor(s(0)).
menor(s(s(0))).
menor(s(s(s(0)))).
menor(s(s(s(s(0))))).

suma([],[s(0)]).
suma(X,Y) :- colaPeano(X,ULT), igual(ULT,s(s(s(s(s(s(s(s(s(0)))))))))), soloNueve(X,NUEVES), quitarNueve(X,NUEVES,NONUEVE), convertZero(NUEVES,ZEROS), suma(NONUEVE,RT), concat(RT,ZEROS,DEV), igual(DEV,Y).
suma(X,Y) :- colaPeano(X,ULT), \=(ULT,s(s(s(s(s(s(s(s(s(0)))))))))), inicio(X, INI), concat(INI,[s(ULT)],DEV), igual(DEV,Y).

redondear(redondeoUnidad, OrEnt, [Decim|_], RedEnt, []) :- mayor(Decim), suma(OrEnt, Y), igual(Y,RedEnt).
redondear(redondeoUnidad, X, [Decim|_], X, []) :- menor(Decim).
redondear(redondeoDecima, OrEnt, [Decim|[Cent|_]], RedEnt, [RedDec|[]]) :- mayor(Cent), concat(OrEnt, [Decim], ORIG), suma(ORIG,SUM), igual(SUM,DEV), concat(RedEnt,[RedDec],DEV).
redondear(redondeoDecima, X, [Decim|[Cent|_]], X, [Decim|[]]) :- menor(Cent).
redondear(redondeoCentesima, OrEnt, [Decim|[Cent|[Mili|_]]], RedEnt, [RedDec|[RedCent|[]]]) :- mayor(Mili), concat(OrEnt, [Decim,Cent], ORIG), suma(ORIG,SUM), igual(SUM,DEV), concat(RedEnt,[RedDec,RedCent], DEV).
redondear(redondeoCentesima, X, [Decim|[Cent|[Mili|_]]], X, [Decim|[Cent|[]]]) :- menor(Mili).

redondearDecimal(NOrig, TipoRedondeo, redondeo(TipoRedondeo, numeroOriginal(',', OrEnt, OrDec), numeroRedondeado(',', RedEnt, RedDec))) :- numOriginal(NOrig), redondear(TipoRedondeo, OrEnt, OrDec, RedEnt, RedDec).

%%% EJERCICIO 2

par(s(s(0))).
par(s(s(X))) :-  par(X).

sumaSecreto(0,X,X).
sumaSecreto(X,0,X).
sumaSecreto(s(X),Y,s(Z)) :- sumaSecreto(X,Y,Z).

comprobarSecreto(A,B,C,A,D) :- par(A), igual(A,D), sumaSecreto(B,C,D).
comprobarSecreto(C,A,B,A,D) :- par(A), igual(A,D), sumaSecreto(B,C,D).
comprobarSecreto(B,C,A,A,D) :- par(A), igual(A,D), sumaSecreto(B,C,D).
comprobarSecreto(A,A,B,C,D) :- par(A), igual(A,D), sumaSecreto(B,C,D).
comprobarSecreto(A,B,A,C,D) :- par(A), igual(A,D), sumaSecreto(B,C,D).
comprobarSecreto(B,A,A,C,D) :- par(A), igual(A,D), sumaSecreto(B,C,D).


esCuadradoFantasticoSecreto(Matriz, NumSecreto) :- primero(Matriz, PrimeraFila), colaPeano(Matriz, UltimaFila), primero(PrimeraFila,A), colaPeano(PrimeraFila,B), primero(UltimaFila,C), colaPeano(UltimaFila,D), comprobarSecreto(A,B,C,D,NumSecreto).
