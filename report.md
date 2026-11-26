# COMP480 Mini Project 2 — Prolog Knowledge-Base and Reasoning System

## Project objectives

This project uses SWI-Prolog to build three knowledge bases. Each stores facts and uses rules to answer questions. We use recursion to find indirect relationships and paths, list processing to handle results, and backtracking to find puzzle solutions. We also use successor numerals for counts.

## Implementation overview

The Transportation Network models illustrative British Columbia city connections and distances. It supports direct connection checks, reachability, cycle-safe route generation, route-distance calculation, shortest-route selection, and planning a multi-stop route under a distance limit.

The Library Management System stores fifteen books with authors, genres, publication years, members, and borrowing records. It identifies available and borrowed books, searches authors and genres, recommends available books based on prior borrowing, traverses a genre-category graph, and allocates distinct books to readers with genre preferences.

The Game World Adventure stores locations, map links, inventories, quests, quest prerequisites, and completed quests. It searches the world map safely, checks player possessions, verifies recursive quest dependencies, identifies available quests, and generates distinct item assignments.

## Main functions

`reachable/2`, `can_reach/2`, `route/3`, and `path/3` keep a list of visited places. They stop when they reach the destination; otherwise, they try an unvisited neighbour. For example, `path(village, dungeon, P)` can follow the forest and castle to the dungeon. The visited list prevents the search from going around in circles.

`route_distance/2` adds the first road's distance to the distance of the rest of the route. `shortest_route/4` collects simple routes and selects one with the lowest distance. In the library, `genre_path/3` searches between related genres; for example, fantasy connects to literature through fiction. In the game world, `dependencies_met/2` checks every prerequisite and its own prerequisites before a quest can be completed.

All domains include `remove_duplicates/2` and successor-numeral predicates. Values such as `s(s(0))` represent counts without relying on ordinary integer notation. The allocation and item-assignment predicates leave variables unbound so Prolog can use backtracking to enumerate valid solutions.

## Challenges and solutions

Two-way links can make a search loop, so the path rules track visited places. Another issue was checking quests with more than one prerequisite: the dependency rule now checks all of them, and also stops if it encounters a cycle. Each domain has its own utilities so it can run on its own.

## Team member information

| First name | Last name | Student ID | Email address |
| --- | --- | --- | --- |
| [enter] | [enter] | [enter] | [enter] |
| [enter] | [enter] | [enter] | [enter] |
| [enter] | [enter] | [enter] | [enter] |

## Individual contributions

| Team member | Contribution |
| --- | --- |
| [enter name] | [describe contribution] |
| [enter name] | [describe contribution] |
| [enter name] | [describe contribution] |

*Export this source to `report.pdf` before submission. Its content is designed to fit within three pages using standard 11–12 pt formatting.*
