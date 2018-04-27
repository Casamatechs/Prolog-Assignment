alumno_prode('Marin','Sanchez','Carlos','120131').

%%% EJERCICIO 1
numero(0).
numero(s(X)) :- numero(X).

esNumero([X|Y]) :- numero(X), parteEntera(Y).

parteEntera([','|X]) :- parteDecimal(X).
parteEntera([X|Y]) :- numero(X), parteEntera(Y).

parteDecimal([]).
parteDecimal([X|Y]) :- numero(X), parteDecimal(Y).

listaPeano([]).
listaPeano([X|Y]) :- numero(X), listaPeano(Y).

colaPeano([X|[]],X).
colaPeano([_|X],Y) :- colaPeano(X,Y).

inicio([X],[]) :- numero(X).
inicio([X|Z],[X|W]) :- inicio(Z,W).

primero([X|_],X).
quitarCabeza([_|X],X).

concat([],Xfinal, Xfinal) :- listaPeano(Xfinal).
concat([X|Y],Z, [X|Xfinal]) :- numero(X), concat(Y,Z,Xfinal).

soloNueve([],[]).
soloNueve(X,[]) :- colaPeano(X,Y), \=(Y,s(s(s(s(s(s(s(s(s(0)))))))))).
soloNueve(X,[s(s(s(s(s(s(s(s(s(0)))))))))|Y]) :- inicio(X,Z), colaPeano(X,XX), igual(XX,s(s(s(s(s(s(s(s(s(0)))))))))), soloNueve(Z,Y).

convertZero([],[]).
convertZero([_|X],[0|Y]) :- convertZero(X,Y).

checkNueves([s(s(s(s(s(s(s(s(s(0)))))))))|[]],[]).
checkNueves([s(s(s(s(s(s(s(s(s(0)))))))))|Y],[]) :- checkNueves(Y,[]).

checkNotOnlyNueves(X) :- checkNotOnlyNueves_(X,s(s(s(s(s(s(s(s(s(0)))))))))).
checkNotOnlyNueves_(0,s(_)).
checkNotOnlyNueves_(s(X),s(Y)) :- checkNotOnlyNueves_(X,Y).

quitarNueve(X,X,[]).
quitarNueve([X|XX], Y, [X|ZZ]) :- quitarNueve(XX,Y,ZZ).

igual(X,X).

mayor(s(s(s(s(s(0)))))).
mayor(s(X)) :- mayor(X).

menor(X) :- menor_(X,s(s(s(s(s(0)))))).
menor_(0,s(_)).
menor_(s(X),s(Y)) :- menor_(X,Y).

suma([],[s(0)]).
suma(X,Y) :- colaPeano(X,ULT), igual(ULT,s(s(s(s(s(s(s(s(s(0)))))))))), soloNueve(X,NUEVES), quitarNueve(X,NUEVES,NONUEVE), convertZero(NUEVES,ZEROS), suma(NONUEVE,RT), concat(RT,ZEROS,DEV), igual(DEV,Y).
suma(X,Y) :- colaPeano(X,ULT), checkNotOnlyNueves(ULT), inicio(X, INI), concat(INI,[s(ULT)],DEV), igual(DEV,Y).

redondear(redondeoUnidad, OrEnt, [Decim|_], RedEnt, []) :- mayor(Decim), suma(OrEnt, Y), igual(Y,RedEnt).
redondear(redondeoUnidad, X, [Decim|_], X, []) :- menor(Decim).
redondear(redondeoDecima, OrEnt, [Decim|[Cent|_]], RedEnt, []) :- mayor(Cent), checkNueves([Decim],[]), suma(OrEnt,RedEnt).
redondear(redondeoDecima, OrEnt, [Decim|[Cent|_]], RedEnt, [RedDec|[]]) :- mayor(Cent), checkNotOnlyNueves(Decim), concat(OrEnt, [Decim], ORIG), suma(ORIG,SUM), igual(SUM,DEV), concat(RedEnt,[RedDec],DEV).
redondear(redondeoDecima, X, [Decim|[Cent|_]], X, [Decim|[]]) :- menor(Cent).
redondear(redondeoCentesima, OrEnt, [Decim|[Cent|[Mili|_]]], RedEnt, []) :- mayor(Mili), concat([Decim],[Cent],DEC), checkNueves(DEC,[]), suma(OrEnt,RedEnt).
redondear(redondeoCentesima, OrEnt, [Decim|[Cent|[Mili|_]]], RedEnt, [RedDec|[RedCent|[]]]) :- mayor(Mili), checkNotOnlyNueves(Decim), checkNotOnlyNueves(Cent), concat(OrEnt, [Decim,Cent], ORIG), suma(ORIG,SUM), igual(SUM,DEV), concat(RedEnt,[RedDec,RedCent], DEV).
redondear(redondeoCentesima, X, [Decim|[Cent|[Mili|_]]], X, [Decim|[Cent|[]]]) :- menor(Mili).

redondearDecimal(NOrig, TipoRedondeo, redondeo(TipoRedondeo, numeroOriginal(',', OrEnt, OrDec), numeroRedondeado(',', RedEnt, RedDec))) :- esNumero(NOrig), redondear(TipoRedondeo, OrEnt, OrDec, RedEnt, RedDec).

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