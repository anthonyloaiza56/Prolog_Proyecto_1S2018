%CODIGO DEL PROYECTO AKITICOLOG
%Base, edad, donde vive, bebida favorita xD(random, por el momento)
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


nery([],"Nery Brenes").
nery([X|T],R):-X= atletismo,nery(T,R).
nery([X|T],R):-X= hombre,nery(T,R).
nery([X|T],R):-X= si,nery(T,R).
nery([X|T],R):-X= limon,nery(T,R).
nery([X|T],R):-X= siguiente ,nery(T,R).

%si no se sabe la pregunta, escribir siguiente, para seguir con la siguiente pregunta


hanna([],"Hanna Gabriels").
hanna([X|T],R):-X= boxeo,hanna(T,R).
hanna([X|T],R):-X= mujer,hanna(T,R).
hanna([X|T],R):-X= si,hanna(T,R).
hanna([X|T],R):-X= alajuela,hanna(T,R).
hanna([X|T],R):-X= siguiente ,hanna(T,R).



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
nacimiento(N):-
    write("1) Donde nació?"),nl,
    read(Inpt),nl,
    atomic_list_concat(L,' ',Inpt),nl,
    miembroPos(nacio,L,N,1).  
%estructura de respuesta comun: si o no
edad_mayor_25(E):-
    write("2) Tiene más de 25 años(si/no)?"),nl,
    read(Inpt),
    atomic_list_concat(L,' ',Inpt)
    ,match(L,0,E).
%estructura de respuesta comun: "se dedica al ..."
deporte(D):-
    write("3) A que deporte se dedica principalmente(sino practica ninguno, puedes escribir 'nunguno')?"),nl,
    read(Inpt),nl,
    atomic_list_concat(L,' ',Inpt),nl,
    miembroPos(al,L,D,0).
%estructura de respuesta comun: " ella/el es mujer/hombre..."
sexo(S):-
    write("4) Es hombre o mujer?"),nl,
    read(Inpt),
    atomic_list_concat(L,' ',Inpt),
    miembroPos(es,L,S,0).

revisar(_,_,0).
revisar(L,R,N):- hanna(L,R),append([],R,L_r), Nn is N-1,revisar(L,L_r,Nn).
revisar(L,R,N):- nery(L,R),append([],R,L_r), Nn is N-1,revisar(L,L_r,Nn).
revisar(L,R,N):- Nn is N-1,revisar(L,R,Nn).


iniciar:-
    write("Bienvenido a AkiTicoLog!"),nl,
    write("Piensa en un personaje de costa rica, intentare adivinarlo"),nl,
    nacimiento(N),edad_mayor_25(E),deporte(D),sexo(S),append([],[N,E,D,S],L),revisar(L,R,2),write("Piensa en "),write(R).


