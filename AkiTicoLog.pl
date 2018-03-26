%CODIGO DEL PROYECTO AKITICOLOG
nacimiento:-
    write("Donde nació?"),nl,
    read(Inpt),nl,
    atomic_list_concat(L,' ',Inpt),nl,
    write(L).
