/* function for work with list - BEGIN */
writenlist([]):-
    nl.

writenlist([H|T]):-
    write(H),
    write(' '),
    writenlist(T).

reverse_writenllist([]).

reverse_writenllist([H|T]):-
    reverse_writenllist(T),
    write(H),
    nl.  

member(X,[X|_]).

member(X,[_|T]):-
    member(X,T).

/* function for work with list - END */

/* change value from e (East) to w (West) */
opposite(e,w).

/* change value from w (West) to e (East) */
opposite(w,e).

/* Weights for each person */
weight(man, 80).
weight(woman, 80).
weight(child1, 30).
weight(child2, 30).

/* Boat capacity */
boat_capacity(100).

/* Check if the total weight of a list of people is within boat's capacity */
valid_boat_crossing(People) :-
    boat_capacity(MaxCapacity),
    total_weight(People, TotalWeight),
    TotalWeight =< MaxCapacity.

/* Calculate the total weight of a list of people */
total_weight([], 0).
total_weight([Person | Rest], TotalWeight) :-
    weight(Person, W),
    total_weight(Rest, RestWeight),
    TotalWeight is W + RestWeight.

/* Move people across the river */
move(state(Left, Right, left), state(NewLeft, NewRight, right)) :-
    select_people(Left, Crossing, NewLeft),
    append(Crossing, Right, NewRight),
    valid_boat_crossing(Crossing),
    writenlist(['Boat moves from left to right with ', Crossing, ' Left:', NewLeft, ' Right:', NewRight]).

move(state(Left, Right, right), state(NewLeft, NewRight, left)) :-
    select_people(Right, Crossing, NewRight),
    append(Crossing, Left, NewLeft),
    valid_boat_crossing(Crossing),
    writenlist(['Boat moves from right to left with ', Crossing, ' Left:', NewLeft, ' Right:', NewRight]).

select_people(Bank, [A], NewBank) :-
    select(A, Bank, NewBank).
select_people(Bank, [A, B], NewBank) :-
    select(A, Bank, TempBank),
    select(B, TempBank, NewBank).

path(Goal, Goal, List):-
    write('Solution Path is: '),
    nl,
    reverse_writenllist(List).

/* make move */
path(State, Goal, List):-
    move(State, NextState),
    not(member(NextState, List)),
    path(NextState, Goal, [NextState|List]),
    !.

/* run program */
:-  
    path(state([man, woman, child1, child2], [], left), state([], [man, woman, child1, child2], right), [state([man, woman, child1, child2], [], left)]),
    halt(0).
