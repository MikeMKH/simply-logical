% https://book.simply-logical.space/src/text/2_part_ii/5.1.html

% search(Agenda,Goal) <- Goal is a goal node, and a
%                        descendant of one of the nodes
%                        on the Agenda
search(Agenda,Goal):-
  next(Agenda,Goal,_Rest),
  goal(Goal).
search(Agenda,Goal):-
  next(Agenda,Current,Rest),
  children(Current,Children),
  add(Children,Rest,NewAgenda),
  search(NewAgenda,Goal).

next([Current|Rest], Current, Rest) :-
  write('processing: '),write(Current),nl.
children(_, []).
add(Children, Rest, Next) :- append(Children, Rest, Next).
goal(X) :- write('found: '),write(X),nl.

% ?- search([1, 2, 3, 4, 5, 5, 4, 3, 2, 1], 4).
% processing: 1
% processing: 2
% processing: 3
% processing: 4
% found: 4
% true ;
% processing: 4
% processing: 5
% processing: 5
% processing: 4
% found: 4
% true ;
% processing: 4
% processing: 3
% processing: 2
% processing: 1
% false.

% https://book.simply-logical.space/src/text/2_part_ii/5.2.html

% depth-first search
search_df([Goal|_Rest],Goal):-
  goal_df(Goal).
search_df([Current|Rest],Goal):-
  children_df(Current,Children),
  append(Children,Rest,NewAgenda),
  search_df(NewAgenda,Goal).

children_df(Node,Children):-
  findall(C,arc_df(Node,C),Children).
  
% nodes are lists of letters
arc_df(T,[H|T]):-
  length(T,N),N<11,     % this sets a depth bound
  member(H,[a,d,i,m]).  % only use these letters

% find palindromes
goal_df(L):-
  reverse(L,L).

% ?- search_df([[1,2,1]], X).
% X = [1, 2, 1] ;
% false.

% ?- search_df([[1, 2, 3, 2, 1]], X).
% X = [1, 2, 3, 2, 1] .

% ?- search_df([[1, 2,  2, 1]], X).
% X = [1, 2, 2, 1] .

% ?- search_df([[1, 2, 3, 1]], X).
% false.

% ?- search_df([[a,d,i,d,a]], X).
% X = [a, d, i, d, a] ;
% X = [a, d, i, d, a, a, a, d, i|...] ;
% X = [a, d, i, d, a, a, d, i, d|...] ;
% X = [a, d, i, d, a, d, a, d, i|...] ;
% X = [a, d, i, d, a, d, i, d, a] ;
% X = [a, d, i, d, a, i, a, d, i|...] .

% ?- search_df([[a,d,i,x,d,a]], X).
% false.

% ?- search_df([[a,d,i,i,d,a]], X).
% X = [a, d, i, i, d, a] ;
% X = [a, d, i, i, d, a, d, i, i|...] .

% ?- search_df([[a,d,i,x,i,d,a]], X).
% X = [a, d, i, x, i, d, a] ;
% false.

% ?- search_df([[a,d,i,x,q,x,i,d,a]], X).
% X = [a, d, i, x, q, x, i, d, a] ;
% false.

% depth-first search by means of backtracking
search_bt(Goal,Goal):-
  goal_bt(Goal).
search_bt(Current,Goal):-
  arc_bt(Current,Child),
  search_bt(Child,Goal).

arc_bt(N1, N) :-
  N1 >= 0,
  succ(N, N1).

goal_bt(X) :-
  0 =:= X mod 3,
  write('found: '),write(X),nl.

% ?- search_bt(7, X).
% found: 6
% X = 6 ;
% found: 3
% X = 3 ;
% found: 0
% X = 0 ;
% false.

% iterative deepening
search_id(First,Goal):-
  search_id(1,First,Goal).     % start with depth 1

search_id(_D,Current,Goal):-
  search_bt(Current,Goal).
search_id(D,Current,Goal):-
  D1 is D+1,                   % increase depth
  search_id(D1,Current,Goal).

% ?- search_id(7, X).
% found: 6
% X = 6 ;
% found: 3
% X = 3 ;
% found: 0
% X = 0 ;
% found: 6
% X = 6 ;
% found: 3
% X = 3 ;
% found: 0
% X = 0 ;
% found: 6
% X = 6 .