% Game World Adventure knowledge base.
player(player1). player(player2).
character(player1, ranger). character(player2, mage).
location(village). location(forest). location(castle). location(mountain).
location(cave). location(dungeon). location(river). location(ruins).
link(village, forest). link(forest, castle). link(forest, river).
link(river, mountain). link(mountain, cave). link(cave, dungeon).
link(castle, dungeon). link(castle, ruins). link(ruins, cave).
connected(A, B) :- link(A, B).
connected(A, B) :- link(B, A).

item(sword). item(map). item(torch). item(key). item(amulet). item(healing_potion).
treasure(amulet, dungeon). treasure(key, cave).
inventory(player1, [sword,map,torch,key]).
inventory(player2, [amulet,healing_potion]).
has_item(Player, Item) :- inventory(Player, Items), member_of(Item, Items).

enemy(goblin, forest). enemy(dragon, mountain). enemy(guardian, dungeon).
quest(find_key). quest(slay_dragon). quest(retrieve_amulet). quest(explore_dungeon).
quest_requirement(find_key, map).
quest_requirement(slay_dragon, sword).
quest_requirement(retrieve_amulet, key).
quest_requirement(explore_dungeon, torch).
quest_dependency(retrieve_amulet, find_key).
quest_dependency(explore_dungeon, retrieve_amulet).
completed(player1, find_key). completed(player1, slay_dragon).

can_reach(From, To) :- can_reach_(From, To, [From]).
can_reach_(To, To, _).
can_reach_(From, To, Seen) :- connected(From, Next), \+ member_of(Next, Seen), can_reach_(Next, To, [Next|Seen]).
path(From, To, Path) :- path_(From, To, [From], Reverse), reverse(Reverse, Path).
path_(To, To, Seen, Seen).
path_(From, To, Seen, Path) :- connected(From, Next), \+ member_of(Next, Seen), path_(Next, To, [Next|Seen], Path).

% Dependencies are recursively checked before a quest can be completed.
dependencies_met(_, Quest) :- \+ quest_dependency(Quest, _).
dependencies_met(Player, Quest) :- quest_dependency(Quest, Parent), completed(Player, Parent), dependencies_met(Player, Parent).
can_complete_quest(Player, Quest) :- quest(Quest), quest_requirement(Quest, Item), has_item(Player, Item), dependencies_met(Player, Quest).
available_quest(Player, Quest) :- can_complete_quest(Player, Quest), \+ completed(Player, Quest).

% A backtracking item puzzle: each hero receives a distinct required item.
item_assignment(RangerItem, MageItem, ScoutItem) :-
    member_of(RangerItem, [sword,torch,key]),
    member_of(MageItem, [amulet,healing_potion,map]),
    member_of(ScoutItem, [map,torch,key]),
    RangerItem \= MageItem, RangerItem \= ScoutItem, MageItem \= ScoutItem.

path_steps(Path, Steps) :- succ_length(Path, Count), predecessor(Count, Steps).
predecessor(s(N), N).
