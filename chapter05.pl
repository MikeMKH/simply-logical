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