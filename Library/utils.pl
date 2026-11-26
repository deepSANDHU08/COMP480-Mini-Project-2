member_of(X, [X|_]).
member_of(X, [_|Tail]) :- member_of(X, Tail).

remove_duplicates([], []).
remove_duplicates([Head|Tail], Result) :- member_of(Head, Tail), !, remove_duplicates(Tail, Result).
remove_duplicates([Head|Tail], [Head|Result]) :- remove_duplicates(Tail, Result).

succ_add(0, N, N).
succ_add(s(N), M, s(Result)) :- succ_add(N, M, Result).
succ_length([], 0).
succ_length([_|Tail], s(Result)) :- succ_length(Tail, Result).
