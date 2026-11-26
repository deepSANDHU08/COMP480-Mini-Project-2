% Transportation Network.  Distances are illustrative example data (kilometres).

city(vancouver). city(surrey). city(abbotsford). city(chilliwack).
city(hope). city(merritt). city(kamloops). city(kelowna). city(whistler).

road(vancouver, surrey, 30). road(surrey, abbotsford, 65).
road(abbotsford, chilliwack, 35). road(chilliwack, hope, 55).
road(hope, merritt, 120). road(merritt, kamloops, 85).
road(merritt, kelowna, 110). road(kamloops, kelowna, 105).
road(vancouver, whistler, 120). road(whistler, kamloops, 300).

% Roads are bidirectional.
connected(A, B) :- road(A, B, _).
connected(A, B) :- road(B, A, _).
distance(A, B, D) :- road(A, B, D).
distance(A, B, D) :- road(B, A, D).

% Visited cities ensure that cyclic networks still terminate.
reachable(From, To) :- reachable_(From, To, [From]).
reachable_(To, To, _).
reachable_(From, To, Visited) :-
    connected(From, Next),
    \+ member_of(Next, Visited),
    reachable_(Next, To, [Next|Visited]).

route(From, To, Path) :- route_(From, To, [From], Reversed), reverse(Reversed, Path).
route_(To, To, Visited, Visited).
route_(From, To, Visited, Path) :-
    connected(From, Next),
    \+ member_of(Next, Visited),
    route_(Next, To, [Next|Visited], Path).

all_routes(From, To, Routes) :- findall(Path, route(From, To, Path), Raw), remove_duplicates(Raw, Routes).
route_distance([_], 0).
route_distance([A,B|Tail], Total) :- distance(A, B, D), route_distance([B|Tail], Rest), Total is D + Rest.
shortest_route(From, To, Path, Distance) :-
    setof(D-P, R^(route(From, To, R), route_distance(R, D), P = R), [Distance-Path|_]).
reachable_cities(From, Cities) :- findall(C, (city(C), C \= From, reachable(From, C)), Raw), remove_duplicates(Raw, Cities).

% A simple route-planning CSP: select distinct intermediate stops with a budget.
route_plan(Start, Finish, Stop1, Stop2, Total) :-
    connected(Start, Stop1), connected(Stop1, Stop2), connected(Stop2, Finish),
    Stop1 \= Stop2, Stop1 \= Start, Stop2 \= Finish,
    route_distance([Start,Stop1,Stop2,Finish], Total), Total =< 300.

route_segments(Path, Segments) :- succ_length(Path, Count), predecessor(Count, Segments).
predecessor(s(N), N).
