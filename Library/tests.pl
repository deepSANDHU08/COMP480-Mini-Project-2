:- begin_tests(library).
:- [utils].
:- [kb].
test(available_book) :- available(b2).
test(unavailable_book, [fail]) :- available(b1).
test(borrower) :- borrower_of(b3, alex).
test(borrowed_by) :- borrowed_by(blair, b5).
test(member_loans) :- books_borrowed_by(alex, [b1,b3]).
test(author_search) :- books_by_author(austen, [b5,b6]).
test(genre_search) :- books_by_genre(mystery, [b7,b8,b15]).
test(genre_recursive_path, [nondet]) :- genre_path(fantasy, literature, [fantasy,fiction,literature]).
test(genre_path_reverse, [nondet]) :- genre_path(literature, biography, [literature,non_fiction,biography]).
test(recommendation) :- recommend_book(alex, b4).
test(recommendation_titles, [nondet]) :- recommended_titles(alex, Titles), member('Foundation', Titles), \+ member('Dune', Titles).
test(allocation_csp) :- allocation(b2, b7, b4).
test(successor_loans) :- loan_count(alex, s(s(0))).
test(successor_addition) :- succ_add(s(0), s(s(0)), s(s(s(0)))).
test(duplicates) :- remove_duplicates([x,y,x,z,y], [x,z,y]).
:- end_tests(library).

% Example interactive queries:
% ?- available(Book).                         % multiple book identifiers
% ?- borrowed_by(alex, Book).                 % bindings via backtracking
% ?- recommend_book(alex, Book).              % available same-genre titles
% ?- genre_path(fantasy, literature, Path).   % recursive path
% ?- allocation(A, B, C).                     % constraint puzzle solutions
