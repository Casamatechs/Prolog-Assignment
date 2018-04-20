numero(0).
numero(s(X)) :- numero(X).

numOriginal(ParteEntera, ',', ParteDecimal) :- listaPeano(ParteEntera), listaPeano(ParteDecimal).
numRedondeo(',', ParteEntera, ParteDecimal) :- listaPeano(ParteEntera), listaPeano(ParteDecimal).

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

soloNueve(X,[]) :- colaPeano(X,Y), \=(Y,s(s(s(s(s(s(s(s(s(0)))))))))).
soloNueve(X,[s(s(s(s(s(s(s(s(s(0)))))))))|Y]) :- inicio(X,Z), colaPeano(X,XX), igual(XX,s(s(s(s(s(s(s(s(s(0)))))))))), soloNueve(Z,Y).

convertZero([],[]).
convertZero([_|X],[0|Y]) :- convertZero(X,Y).

quitarNueve(X,[]) :- primero(X,Y), igual(Y,s(s(s(s(s(s(s(s(s(0)))))))))).
quitarNueve([X|Y], [X|Z]) :- \=(X,s(s(s(s(s(s(s(s(s(0)))))))))), quitarNueve(Y,Z).


igual(X,X).

suma([],[s(0)]).
suma(X,Y) :- colaPeano(X,ULT), igual(ULT,s(s(s(s(s(s(s(s(s(0)))))))))), quitarNueve(X,NONUEVE), soloNueve(X,NUEVES), convertZero(NUEVES,ZEROS), suma(NONUEVE,RT), concat(RT,ZEROS,DEV), igual(DEV,Y).
%suma(X,Y) :- colaPeano(X,ULT), inicio(X,INI).
suma(X,Y) :- colaPeano(X,ULT), \=(ULT,s(s(s(s(s(s(s(s(s(0)))))))))), inicio(X, INI), concat(INI,[s(ULT)],DEV), igual(DEV,Y).
