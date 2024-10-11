parent(i, son).
parent(father, i).

get_father(X, Y) :- parent(X, Y).

that_man(X) :-
    get_father(Y, X), parent(father, Y).
