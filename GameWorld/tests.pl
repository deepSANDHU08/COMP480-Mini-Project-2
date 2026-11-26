:- begin_tests(game_world).
:- [utils].
:- [kb].
test(direct_link, [nondet]) :- connected(village, forest).
test(reverse_link) :- connected(forest, village).
test(no_direct_link, [fail]) :- connected(village, dungeon).
test(recursive_reachability, [nondet]) :- can_reach(village, dungeon).
test(unreachable, [fail]) :- can_reach(village, island).
test(path_endpoints, [nondet]) :- path(village, dungeon, [village|Tail]), last(Tail, dungeon).
test(path_simple, [nondet]) :- path(village, dungeon, P), sort(P, U), length(P, N), length(U, N).
test(inventory, [nondet]) :- has_item(player1, sword).
test(missing_item, [fail]) :- has_item(player2, sword).
test(completable_quest, [nondet]) :- can_complete_quest(player1, retrieve_amulet).
test(quest_dependency, [fail]) :- can_complete_quest(player2, explore_dungeon).
test(available_quest, [nondet]) :- available_quest(player1, retrieve_amulet).
test(item_puzzle, [nondet]) :- item_assignment(sword, amulet, map).
test(path_successor_steps) :- path_steps([village,forest,castle,dungeon], s(s(s(0)))).
test(successor_arithmetic) :- succ_add(s(s(0)), s(0), s(s(s(0)))).
test(duplicates) :- remove_duplicates([a,b,a,c], [b,a,c]).
:- end_tests(game_world).

% Example interactive queries:
% ?- connected(village, forest).                % true
% ?- connected(village, dungeon).               % false
% ?- path(village, dungeon, Path).              % paths through backtracking
% ?- has_item(player1, sword).                  % inventory lookup
% ?- can_complete_quest(player1, Quest).        % recursive quest reasoning
% ?- item_assignment(Ranger, Mage, Scout).      % CSP solutions
