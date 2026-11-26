# COMP480 Mini Project 2: Prolog Knowledge-Base and Reasoning System

This project has three SWI-Prolog knowledge bases. Each uses facts and rules to answer questions and find solutions.

We chose transportation, a library, and a game world because each gives us a different way to use Prolog: finding routes, searching records, and checking quest requirements.

## Domains

**Transportation Network** models illustrative British Columbia road connections. It finds direct and indirect connections, all cycle-safe routes, route distances, shortest routes, reachable cities, and route plans under a distance constraint.  It also represents route-segment counts with successor numerals.

**Library Management** records fifteen books, authors, genres, members, and loans. It checks availability, searches the catalogue, recommends available books from a borrower's genres, traverses a recursive genre graph, and solves a distinct-book allocation puzzle.

**Game World Adventure** models a connected fantasy map, player inventories, items, enemies, quests, and quest dependencies. It performs safe map search, evaluates whether a player can complete or access a quest, and produces item-puzzle solutions.

## Structure

Each domain has the same three files:

- `kb.pl` contains domain facts, rules, recursive reasoning, paths, and puzzles.
- `utils.pl` contains simple recursive list and successor-numeral predicates.
- `tests.pl` loads the other files, contains plunit tests, and ends with commented interactive examples.

`report.md` is the concise report source, ready to export to PDF. `COMP480_mini_project_2.pdf` is the supplied assignment handout.

## Running a knowledge base

Open PowerShell in the project directory. The commands below use the installed SWI-Prolog path on this computer; change it if yours is different. Load one domain at a time because some predicate names are shared.

```powershell
& 'C:\Program Files\swipl\bin\swipl.exe' -s Transportation/kb.pl -s Transportation/utils.pl
& 'C:\Program Files\swipl\bin\swipl.exe' -s Library/kb.pl -s Library/utils.pl
& 'C:\Program Files\swipl\bin\swipl.exe' -s GameWorld/kb.pl -s GameWorld/utils.pl
```

Example queries (run in their corresponding domain):

```prolog
?- reachable(vancouver, kelowna).
true.
?- shortest_route(vancouver, kelowna, Path, Distance).
Path = [vancouver,surrey,abbotsford,chilliwack,hope,merritt,kelowna], Distance = 415.
?- books_by_author(austen, Books).
Books = [b5,b6].
?- path(village, dungeon, Path).
Path = [village,forest,castle,dungeon] ; ...
?- item_assignment(Ranger, Mage, Scout).
```

## Tests

Each suite has at least twelve tests covering direct and failed relations, recursion, path safety, list processing, backtracking puzzles, and successor numerals.

```powershell
& 'C:\Program Files\swipl\bin\swipl.exe' -q -s Transportation/tests.pl -g run_tests -t halt
& 'C:\Program Files\swipl\bin\swipl.exe' -q -s Library/tests.pl -g run_tests -t halt
& 'C:\Program Files\swipl\bin\swipl.exe' -q -s GameWorld/tests.pl -g run_tests -t halt
```

To try the example queries at the end of a `tests.pl` file, load that file in SWI-Prolog and enter the queries at the prompt. Use `;` after an answer to ask for another solution.

## Prolog concepts demonstrated

Facts store the initial data; rules derive new information. Recursive predicates traverse road, genre, map, and dependency graphs. Unification binds query variables, while Prolog backtracking generates alternative routes, recommendations, and puzzle assignments. The project uses explicit visited lists for finite graph search, recursive list utilities for duplicate removal and membership, and terms such as `0`, `s(0)`, and `s(s(0))` for successor-numeral arithmetic.

## Recursion and backtracking in plain language

Think of a recursive predicate as a rule that solves one small part now and asks the same rule to solve the rest.

- `reachable/2`, `route/3`, `can_reach/2`, `path/3`, and `genre_path/3` begin at one node, try a neighbouring node, and repeat until they reach the target. Their **base case** is “the current node already is the target.” Their **recursive case** is “move to an unvisited neighbour and keep searching.” The visited list is the memory of places already used, so a two-way connection cannot make the search loop forever.
- `route_distance/2` takes the first road distance, recursively finds the distance of the remaining route, and adds the two. `succ_length/2` similarly removes one list item at a time and wraps the answer in one more `s(...)`.
- `dependencies_met/2` checks every prerequisite of a quest. For each one, the player must have completed it and the prerequisite's own requirements must also be met. Its visited list makes an accidental circular dependency fail safely rather than recurse forever.

Backtracking is Prolog's built-in “try the next option” behaviour. If a road, path branch, or puzzle choice later fails, Prolog returns to the most recent choice and tries another matching fact. For example, `route/3` can produce another simple route when you ask for `;`, and `allocation/3` or `item_assignment/3` tries different available, distinct choices until it finds each valid assignment. The `\+` checks reject choices that would revisit a node or break a constraint.
