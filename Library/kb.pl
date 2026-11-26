% Library Management System.
book(b1, 'The Hobbit', tolkien, fantasy, 1937).
book(b2, 'The Fellowship of the Ring', tolkien, fantasy, 1954).
book(b3, 'Dune', herbert, science_fiction, 1965).
book(b4, 'Foundation', asimov, science_fiction, 1951).
book(b5, 'Pride and Prejudice', austen, romance, 1813).
book(b6, 'Emma', austen, romance, 1815).
book(b7, 'The Hound of the Baskervilles', doyle, mystery, 1902).
book(b8, 'Murder on the Orient Express', christie, mystery, 1934).
book(b9, 'Sapiens', harari, history, 2011).
book(b10, 'A Brief History of Time', hawking, science, 1988).
book(b11, 'The Martian', weir, science_fiction, 2011).
book(b12, 'Educated', westover, biography, 2018).
book(b13, 'The Name of the Wind', rothfuss, fantasy, 2007).
book(b14, 'Neuromancer', gibson, science_fiction, 1984).
book(b15, 'The Silent Patient', michaelides, mystery, 2019).

member(alex). member(blair). member(casey). member(devon).
loan(alex, b1). loan(alex, b3). loan(blair, b5). loan(casey, b8). loan(devon, b10).

available(Id) :- book(Id, _, _, _, _), \+ loan(_, Id).
borrowed_by(Member, Id) :- loan(Member, Id).
borrower_of(Id, Member) :- loan(Member, Id).
books_borrowed_by(Member, Books) :- findall(Id, loan(Member, Id), Books).
books_by_author(Author, Books) :- findall(Id, book(Id, _, Author, _, _), Books).
books_by_genre(Genre, Books) :- findall(Id, book(Id, _, _, Genre, _), Books).

% Broad genres provide a recursively traversed category graph.
genre_parent(fantasy, fiction). genre_parent(science_fiction, fiction).
genre_parent(mystery, fiction). genre_parent(romance, fiction).
genre_parent(history, non_fiction). genre_parent(science, non_fiction).
genre_parent(biography, non_fiction). genre_parent(fiction, literature).
genre_parent(non_fiction, literature).
genre_related(A, B) :- genre_parent(A, B).
genre_related(A, B) :- genre_parent(B, A).
genre_path(From, To, Path) :- genre_path_(From, To, [From], Reverse), reverse(Reverse, Path).
genre_path_(To, To, Seen, Seen).
genre_path_(From, To, Seen, Path) :-
    genre_related(From, Next),
    \+ member_of(Next, Seen),
    genre_path_(Next, To, [Next|Seen], Path).

% Recommend available books in a genre the member has previously borrowed.
recommend_book(Member, Id) :-
    loan(Member, Borrowed),
    book(Borrowed, _, _, Genre, _),
    available(Id),
    book(Id, _, _, Genre, _),
    Id \= Borrowed.
recommended_titles(Member, Titles) :- findall(Title, (recommend_book(Member, Id), book(Id, Title, _, _, _)), Raw), remove_duplicates(Raw, Titles).

% Allocate three distinct available books, one to each reader, with genre preferences.
allocation(AlexBook, BlairBook, CaseyBook) :-
    available(AlexBook), book(AlexBook, _, _, fantasy, _),
    available(BlairBook), book(BlairBook, _, _, mystery, _),
    available(CaseyBook), book(CaseyBook, _, _, science_fiction, _),
    AlexBook \= BlairBook, AlexBook \= CaseyBook, BlairBook \= CaseyBook.

loan_count(Member, Count) :- books_borrowed_by(Member, Books), succ_length(Books, Count).
