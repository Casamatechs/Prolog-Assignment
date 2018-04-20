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

concat([],Xfinal, Xfinal) :- listaPeano(Xfinal).
concat([X|Y],Z, [X|Xfinal]) :- numero(X), concat(Y,Z,Xfinal).

igual(X,X).

suma([s(s(s(s(s(s(s(s(s(0)))))))))],[s(0),0]).
suma(X,Y) :- colaPeano(X,ULT), \=(ULT,s(s(s(s(s(s(s(s(s(0)))))))))), inicio(X, INI), concat(INI,[s(ULT)],DEV), igual(DEV,Y).
%suma(X,Y) :- colaPeano(X,ULT), =(ULT,s(s(s(s(s(s(s(s(s(0)))))))))), inicio(X,INI), suma(INI,IT).