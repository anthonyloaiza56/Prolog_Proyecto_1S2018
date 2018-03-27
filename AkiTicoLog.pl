%CODIGO DEL PROYECTO AKITICOLOG
% [Nery Brenes,[Nacimiento,Limon],[Dedicacion,
% atletismo],[Sexo,hombre],[Edad_mayor_25, si]]
% [Hanna Gabriels,[Nacimiento, Alajuela],[Dedicacion,
% Boxeo],[Sexo,mujer],[Edad_mayor_25, si]]

% 1.04 (*) Find the number of elements of a list.
%
% recordar usar todo en minuscula y separado por espacios, si escribe
% san jose o provincias de 2 palabras se cae(debo arreglarlo jaja)
count(0, []).
count(C, [_|T]) :- count(X, T), C is X + 1.
% todavia no uso esa funcion, pero puede ser util jaja
hernan([],"Hernan Jimenez").
hernan([X|T],R):-X= ninguno,hernan(T,R).
hernan([X|T],R):-X= hombre,hernan(T,R).
hernan([X|T],R):-X= si,hernan(T,R).
hernan([X|T],R):-X= 'san jose',hernan(T,R).
hernan([X|T],R):-X= siguiente ,hernan(T,R).


nery([],"Nery Brenes").
nery([X|T],R):-X= atletismo,nery(T,R).
nery([X|T],R):-X= hombre,nery(T,R).
nery([X|T],R):-X= no,nery(T,R).
nery([X|T],R):-X= 'san jose',nery(T,R).
nery([X|T],R):-X= siguiente ,nery(T,R).

%si no se sabe la pregunta, escribir siguiente, para seguir con la siguiente pregunta


hanna([],"Hanna Gabriels").
hanna([X|T],R):-X= boxeo,hanna(T,R).
hanna([X|T],R):-X= mujer,hanna(T,R).
hanna([X|T],R):-X= no,hanna(T,R).
hanna([X|T],R):-X= alajuela,hanna(T,R).
hanna([X|T],R):-X= siguiente ,hanna(T,R).

match_tail([_|T],0,T) :-!
    .
match_tail([_|T],N,H) :-
    N > 0, %add for loop prevention
    N1 is N-1,
    match_tail(T,N1,H).
miembroPos_Tail(X,[X|T],Z,P):-match_tail(T,P,Z).
miembroPos_Tail(X,[_|T],Z,P):-miembroPos_Tail(X,T,Z,P).


match([H|_],0,H) :-!
    .
match([_|T],N,H) :-
    N > 0, %add for loop prevention
    N1 is N-1,
    match(T,N1,H).
% valor,lista, lista[P],P
miembroPos(X,[X|T],Z,P):-match(T,P,Z).
miembroPos(X,[_|T],Z,P):-miembroPos(X,T,Z,P).

%estructura de respuesta comun: "nacio en ..."
nacimiento(N,Inpt):-
    atomic_list_concat(L,' ',Inpt),nl,
    miembroPos_Tail(nacio,L,N_sub,0),atomic_list_concat(N_sub,' ',N).
nacimiento(N,Inpt):-
    atomic_list_concat(L,' ',Inpt),nl,
    miembroPos_Tail(en,L,N_sub,0),atomic_list_concat(N_sub,' ',N).

nacimiento(N,Inpt):-
    atomic_list_concat(L,' ',Inpt),nl,
    match(L,0,N).

%estructura de respuesta comun: si o no
comedia(C,Inpt):-
    atomic_list_concat(L,' ',Inpt)
    ,match(L,0,C).
%estructura de respuesta comun: "se dedica al ..."
deporte(D,Inpt):-
    atomic_list_concat(L,' ',Inpt),nl,
    miembroPos(al,L,D,0).
deporte(D,Inpt):-
    atomic_list_concat(L,' ',Inpt),nl,
    match(L,0,D).

%estructura de respuesta comun: " ella/el es mujer/hombre..."
sexo(S,Inpt):-
    atomic_list_concat(L,' ',Inpt),
    miembroPos(es,L,S,0).
sexo(S,Inpt):-
    atomic_list_concat(L,' ',Inpt),
    match(L,0,S).

revisar(_,_,0).
revisar(L,R,N):- hanna(L,R),append([],R,L_r), Nn is N-1,revisar(L,L_r,Nn).
revisar(L,R,N):- hernan(L,R),append([],R,L_r), Nn is N-1,revisar(L,L_r,Nn).
revisar(L,R,N):- nery(L,R),append([],R,L_r), Nn is N-1,revisar(L,L_r,Nn).
revisar(L,R,N):- Nn is N-1,revisar(L,R,Nn).


iniciar:-
    write("Bienvenido a AkiTicoLog!"),nl,
    write("Piensa en un personaje de costa rica, intentare adivinarlo"),nl,

    write("1) Donde nacio?"),nl,
    read(Inpt),nacimiento(N,Inpt),nl,

    write("2) Se dedica a la comedia?(si/no)"),nl,
    read(Inpt2),comedia(C,Inpt2),nl,

    write("3) A que deporte se dedica?(si no practica ninguno escribir 'ninguno')"),nl,
    read(Inpt3),deporte(D,Inpt3),nl,

    write("4)Es hombre o mujer?"),nl,
    read(Inpt4), sexo(S,Inpt4),nl,

    append([],[N,C,D,S],L),revisar(L,R,2),write("Piensa en "),write(R).



