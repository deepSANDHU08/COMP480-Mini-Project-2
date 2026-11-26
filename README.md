# COMP480 Mini Project 2: Prolog Knowledge-Base and Reasoning System

This project is a collection of three SWI-Prolog knowledge bases.  Each one uses facts and rules to answer questions, derive indirect relationships, and search for solutions by backtracking.

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

Open PowerShell in the project directory. On this computer, SWI-Prolog is installed at `C:\Program Files\swipl\bin\swipl.exe`.

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

## Prolog concepts demonstrated

Facts store the initial data; rules derive new information. Recursive predicates traverse road, genre, map, and dependency graphs. Unification binds query variables, while Prolog backtracking generates alternative routes, recommendations, and puzzle assignments. The project uses explicit visited lists for finite graph search, recursive list utilities for duplicate removal and membership, and terms such as `0`, `s(0)`, and `s(s(0))` for successor-numeral arithmetic.
