:- begin_tests(transportation).
:- [utils].
:- [kb].

test(direct_connection, [nondet]) :- connected(vancouver, surrey).
test(reverse_connection) :- connected(surrey, vancouver).
test(no_direct_connection, [fail]) :- connected(vancouver, kelowna).
test(reachable_indirect, [nondet]) :- reachable(vancouver, kelowna).
test(unreachable_city, [fail]) :- reachable(vancouver, victoria).
test(route_has_endpoints, [nondet]) :- route(vancouver, kelowna, [vancouver|Path]), last(Path, kelowna).
test(route_avoids_cycles, [nondet]) :- route(vancouver, kelowna, Path), sort(Path, Unique), length(Path, N), length(Unique, N).
test(all_routes) :- all_routes(vancouver, kelowna, Routes), length(Routes, N), N > 1.
test(route_distance, [nondet]) :- route_distance([vancouver,surrey,abbotsford], 95).
test(shortest_route) :- shortest_route(vancouver, kelowna, [vancouver,surrey,abbotsford,chilliwack,hope,merritt,kelowna], 415).
test(reachable_unique) :- reachable_cities(vancouver, Cities), \+ member(vancouver, Cities), sort(Cities, Unique), length(Cities, N), length(Unique, N).
test(route_plan, [nondet]) :- route_plan(vancouver, chilliwack, surrey, abbotsford, 130).
test(successor_segments) :- route_segments([vancouver,surrey,abbotsford], s(s(0))).
test(successor_addition) :- succ_add(s(s(0)), s(0), s(s(s(0)))).
test(remove_duplicates) :- remove_duplicates([a,b,a,c,b], [a,c,b]).

:- end_tests(transportation).

% Example interactive queries:
% ?- connected(vancouver, abbotsford).             % false
% ?- reachable(vancouver, kelowna).                % true
% ?- route(vancouver, kelowna, Path).              % Path binding; backtrack for more
% ?- shortest_route(vancouver, kelowna, P, D).     % P and D bindings
% ?- route_plan(vancouver, chilliwack, A, B, D).   % CSP solutions by backtracking
