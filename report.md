# COMP480 Mini Project 2 — Prolog Knowledge-Base and Reasoning System

## Project objectives

The objective of this project is to build three small but complete reasoning systems in SWI-Prolog. Each system stores domain facts and applies logical rules to answer queries that are not explicitly stored. Together, the domains demonstrate direct and indirect inference, recursive search, list processing, Prolog unification and backtracking, constraint-style puzzles, and arithmetic represented by successor numerals.

## Implementation overview

The Transportation Network models illustrative British Columbia city connections and distances. It supports direct connection checks, reachability, cycle-safe route generation, route-distance calculation, shortest-route selection, and planning a multi-stop route under a distance limit.

The Library Management System stores fifteen books with authors, genres, publication years, members, and borrowing records. It identifies available and borrowed books, searches authors and genres, recommends available books based on prior borrowing, traverses a genre-category graph, and allocates distinct books to readers with genre preferences.

The Game World Adventure stores locations, map links, inventories, quests, quest prerequisites, and completed quests. It searches the world map safely, checks player possessions, verifies recursive quest dependencies, identifies available quests, and generates distinct item assignments.

## Main functions

`reachable/2`, `can_reach/2`, `route/3`, and `path/3` use a visited list. Their base case succeeds when the current location is the destination; their recursive case selects an unvisited neighbour. This prevents infinite loops in bidirectional graphs.

`route_distance/2` recursively adds edge distances. `shortest_route/4` collects the possible simple routes with their distances and selects the first ordered result. In the library, `available/1`, `borrower_of/2`, `recommend_book/2`, and `genre_path/3` derive catalogue information. In the game world, `has_item/2`, `dependencies_met/2`, and `can_complete_quest/2` combine inventory and dependency facts.

All domains include `remove_duplicates/2` and successor-numeral predicates. Values such as `s(s(0))` represent counts without relying on ordinary integer notation. The allocation and item-assignment predicates leave variables unbound so Prolog can use backtracking to enumerate valid solutions.

## Challenges and solutions

Bidirectional links create cycles, so unrestricted recursive traversal could fail to terminate. Each traversal tracks previously visited nodes and only visits new ones. This also makes generated routes simple routes. A further design concern was keeping independently runnable domains from depending on advanced libraries; each directory therefore has its own small, clearly named list utility file. The automated suites test normal cases, failed cases, recursive inference, duplicate handling, puzzles, and successor arithmetic.

## Team member information

| First name | Last name | Student ID | Email address |
| --- | --- | --- | --- |
| [enter] | [enter] | [enter] | [enter] |
| [enter] | [enter] | [enter] | [enter] |

## Individual contributions

| Team member | Contribution |
| --- | --- |
| [enter name] | [describe contribution] |
| [enter name] | [describe contribution] |

*Export this source to `report.pdf` before submission. Its content is designed to fit within three pages using standard 11–12 pt formatting.*
