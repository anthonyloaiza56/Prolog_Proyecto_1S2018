%CODIGO DEL PROYECTO AKITICOLOG
%CODIGO DEL PROYECTO AKITICOLOG
%Base, edad, donde vive, bebida favorita xD(random, por el momento)

% 1.04 (*) Find the number of elements of a list.
count(0, []).
count(C, [_|T]) :- count(X, T), C is X + 1.

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
    write("Donde nació?"),nl,
    read(Inpt),nl,
    atomic_list_concat(L,' ',Inpt),nl,
    miembroPos(nacio,L,N,1).

%estructura de respuesta comun: si o no
murio(M):-
    write("Está muerto?"),nl,
    read(Inpt),
    atomic_list_concat(L,' ',Inpt)
    ,match(L,0,M).

%estructura de respuesta comun: si o no
es_cantante(C):-
    write("Es cantante?"),nl,
    read(Inpt),
    atomic_list_concat(L,' ',Inpt)
    ,match(L,0,C).
%estructura de respuesta comun: "se dedica al ..."
deporte(D):-
    write("A que deporte se dedica(sino practica ninguno, puedes escribir 'nunguno')?"),nl,
    read(Inpt),nl,
    atomic_list_concat(L,' ',Inpt),nl,
    miembroPos(al,L,D,0).


% guarda en L la lista de respuestas
iniciar:-
    write("Bienvenido a AkiTicoLog!"),nl,
    write("Piensa en un personaje de costa rica, intentare adivinarlo"),nl,
    nacimiento(N),murio(M),es_cantante(C),deporte(D),append([],[N,M,C,D],L),write(L).

