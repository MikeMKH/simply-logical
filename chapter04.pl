% 4.4

arc(n1,n2).
arc(n1,n3).
arc(n2,n4).
arc(n2,n5).
arc(n2,n6).
arc(n5,n7).
arc(n3,n8).
arc(n3,n9).
arc(n9,n10).

% path(P) <- P is a path in the graph given by arc/2
path([Node1,Node2]):-
  arc(Node1,Node2).
path([Node1,Node2|Nodes]):-
  arc(Node1,Node2),
  path([Node2|Nodes]).

% top to bottom, depth first search
% ?- path([n1|Path]).
% Path = [n2] ;
% Path = [n3] ;
% Path = [n2, n4] ;
% Path = [n2, n5] ;
% Path = [n2, n6] ;
% Path = [n2, n5, n7] ;
% Path = [n3, n8] ;
% Path = [n3, n9] ;
% Path = [n3, n9, n10] ;
% false.

% 4.5

% path_leaf(N,P) <- P is a path starting at node N, ending
%                   in a leaf in the graph given by arc/2
path_leaf(Leaf,[Leaf]):-
  leaf(Leaf).
path_leaf(Node1,[Node1|Nodes]):-
  arc(Node1,Node2),
  path_leaf(Node2,Nodes).

leaf(Leaf):-
  not(arc(Leaf,_SomeNode)).

% 4.6

br(X,Y):-br(X,Z),br(Z,Y).
br(paul,peter).

% ?- br(paul,B).
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 0.9Gb, global: 48.6Mb, trail: 0Kb
% ERROR:   Stack depth: 6,336,101, last-call: 0%, Choice points: 6,336,094
% ERROR:   In:
% ERROR:     [6,336,101] user:br(paul, _12733146)
% ERROR:     [6,336,100] user:br(paul, _12733166)
% ERROR:     [6,336,099] user:br(paul, _12733186)
% ERROR:     [6,336,098] user:br(paul, _12733206)
% ERROR:     [6,336,097] user:br(paul, _12733226)
% ERROR: 
% ERROR: Use the --stack_limit=size[KMG] command line option or
% ERROR: ?- set_prolog_flag(stack_limit, 2_147_483_648). to double the limit.
%    Exception: (6,336,100) br(paul, _12733058) ? abort
% % Execution Aborted

:- discontiguous arc/2.

arc(A,B):- resolve(A,(br(X,Y):-[br(X,Z),br(Z,Y)]),B).
arc(A,B):- resolve(A,(br(paul,peter):-[]),B).

% resolve(G,C,NewG) <- the goal G (a list of atoms)
%                      resolves with the clause C (body
%                      is a list) to yield the goal NewG
resolve([H1|T],(H2:-Body),B):-
    H1=H2,                % literal in goal unifies with head of clause
    append(Body,T,B).
resolve([H|T],Clause,[H|B]):-
    resolve(T,Clause,B).  % try next literal

% ?- arc([br(paul,B)],N).
% N = [br(paul, _A), br(_A, B)] ;
% B = peter,
% N = [] ;
% false.

% https://book.simply-logical.space/src/text/2_part_ii/4.3.html

% Classes
instrument(X):-wind(X).
instrument(X):-string(X).
instrument(X):-percussion(X).
wind(X):-woodwind(X).
wind(X):-brass(X).
string(X):-plucked(X).
string(X):-bowed(X).
string(X):-keyboard(X).
percussion(X):-tuned(X).
percussion(X):-untuned(X).

% Instances
woodwind(recorder).
woodwind(flute).
woodwind(oboe).
woodwind(saxophone).
brass(trumpet).
brass(trombone).
brass(horn).
plucked(guitar).
plucked(lute).
plucked(harp).
bowed(violin).
bowed(cello).
keyboard(piano).
tuned(drum).
untuned(snare).

% ?- instrument(X).
% X = recorder ;
% X = flute ;
% X = oboe ;
% X = saxophone ;
% X = trumpet ;
% X = trombone ;
% X = horn ;
% X = drum ;
% X = snare.

function(X,musical):-instrument(X).

% Materials
material(flute,metal).
material(saxophone,metal).
material(X,wood):-woodwind(X).
material(X,metal):-brass(X).
material(X,wood):-string(X).
material(X,metal):-percussion(X).

% Actions
action(oboe,reed(double)).
action(saxophone,reed(single)).
action(harpsichord,plucked).
action(piano,hammered).
action(X,reed(lip)):-brass(X).
action(X,plucked):-plucked(X).
action(X,bowed):-bowed(X).
action(X,hammered):-percussion(X).

% ?- material(flute,M).
% M = metal ;
% M = wood ;
% false.

properties(Inst,Props):-
  attributes(Attrs),
  properties(Attrs,Inst,Props).
properties([],_Inst,[]).
properties([Attr|Attrs],Inst,[Attr=Value|Props]):-
  get_value(Attr,Inst,Value),!,  % only first answer
  properties(Attrs,Inst,Props).

attributes([function,material,action]).

get_value(A,B,C):-
  Goal =.. [A,B,C],
  call(Goal).

% ?- properties(saxophone,P).
% P = [function=musical, material=metal, action=reed(single)].