% https://book.simply-logical.space/src/text/appendices/a_2.html

% element(X,Ys) <- X is an element of the list Ys
element(X,[X|_Ys]).
element(X,[_Y|Ys]):-
    element(X,Ys).

% append(Xs,Ys,Zs) <- list Zs is Xs followed by Ys
append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]):-
    append(Xs,Ys,Zs).

% remove_one(X,Ys,Zs) <- Zs is list Ys minus
%                        one occurrence of X
remove_one(X,[X|Ys],Ys).
remove_one(X,[Y|Ys],[Y|Zs]):-
    remove_one(X,Ys,Zs).

% https://book.simply-logical.space/src/text/3_part_iii/9.0.html

bird(tweety).            bird(polly).
has_feathers(tweety).    has_beak(polly).

flies(X):-bird(X).

% induce(E,H) <- H is inductive explanation of E
induce(E,H):-induce(E,[],H).

induce(true,H,H):-!.
induce((A,B),H0,H):-!,
    induce(A,H0,H1),
    induce(B,H1,H).
induce(A,H0,H):-
    /* not A=true, not A=(_,_) */
    clause(A,B),
    induce(B,H0,H).
induce(A,H0,H):-
    element((A:-B),H0),     % already assumed
    induce(B,H0,H).         % proceed with body of rule
induce(A,H0,[(A:-B)|H]):-   % A:-B can be added to H
    inducible((A:-B)),      % if it's inducible, and
    \+ element((A:-B),H0), % if it's not already there
    induce(B,H0,H).         % proceed with body of rule
    
  inducible((flies(X):-bird(X),has_feathers(X),has_beak(X))).
  inducible((flies(X):-has_feathers(X),has_beak(X))).
  inducible((flies(X):-bird(X),has_beak(X))).
  inducible((flies(X):-bird(X),has_feathers(X))).
  inducible((flies(X):-bird(X))).
  inducible((flies(X):-has_feathers(X))).
  inducible((flies(X):-has_beak(X))).
  inducible((flies(_):-true)).

% ?- induce(flies(tweety),H).
% H = [] ;
% H = [(flies(tweety):-bird(tweety), has_feathers(tweety))] ;
% H = [(flies(tweety):-bird(tweety))] ;
% H = [(flies(tweety):-has_feathers(tweety))] ;
% H = [(flies(tweety):-true)].

% ?- induce(flies(polly),H).
% H = [] ;
% H = [(flies(polly):-bird(polly), has_beak(polly))] ;
% H = [(flies(polly):-bird(polly))] ;
% H = [(flies(polly):-has_beak(polly))] ;
% H = [(flies(polly):-true)].

% 9.2
% from ChatGPT

covers_ex(Clause, Example, Positives) :-
  \+ (member(P, Positives), \+ (Clause, P)),
  (Clause, Example).

% example

% Define some predicates
male(john).
male(tom).
female(mary).
parent(john, tom).
parent(john, mary).

% Define a clause that covers all male parents
male_parent(X, Y) :- parent(X, Y), male(X).

% Define some positive and negative examples
positive_examples([male_parent(john, tom), male_parent(john, mary)]).
negative_examples([male_parent(mary, john), male_parent(tom, john)]).

% Test if male_parent/2 extensionally covers male_parent(john, tom)
% ?- positive_examples(Positives), covers_ex(male_parent(_, _), male_parent(john, tom), Positives).
% Positives = [male_parent(john, tom), male_parent(john, mary)] .

% Test if male_parent/2 extensionally covers male_parent(mary, john)
% ?- positive_examples(Positives), covers_ex(male_parent(_, _), male_parent(mary, john), Positives).
% false.

% https://book.simply-logical.space/src/text/3_part_iii/9.2.html

my_append1([A|B],C,[A|D]):-
  my_append1([1,2],[3,4],[1,2,3,4]),my_append1([A|B],C,[A|D]),
  my_append1(W,C,X),my_append1([S|B],[3,4],[S,T,U|V]),
  my_append1([R|G],K,[R|L]),my_append1([a],[],[a]),
  my_append1(Q,[],Q),my_append1([P],K,[P|K]),my_append1(N,K,O),
  my_append1(M,[],M),my_append1([],[],[]),my_append1(G,K,L),
  my_append1([F|G],[3,4],[F,H,I|J]),my_append1([E],C,[E|C]),
  my_append1(B,C,D),my_append1([2],[3,4],[2,3,4]).

% ?- my_append1([1, 2], [3, 4, 5], R).
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 0.5Gb, global: 0.5Gb, trail: 0Kb
% ERROR:   Stack depth: 2,580,652, last-call: 0%, Choice points: 3
% ERROR:   Probable infinite recursion (cycle):
% ERROR:     [2,580,652] user:my_append1([length:2], [length:2], [length:4])
% ERROR:     [2,580,651] user:my_append1([length:2], [length:2], [length:4])
% ?- my_append1([1, 2], [3, 4], R).
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 0.5Gb, global: 0.5Gb, trail: 0Kb
% ERROR:   Stack depth: 2,580,737, last-call: 0%, Choice points: 3
% ERROR:   Probable infinite recursion (cycle):
% ERROR:     [2,580,737] user:my_append1([length:2], [length:2], [length:4])
% ERROR:     [2,580,736] user:my_append1([length:2], [length:2], [length:4])

my_append([],C,C).
my_append([A|B],C,[A|D]):-
  my_append(B,C,D).

% ?- my_append([1, 2], [3, 4, 5], [1, 2, 3, 4, 5]).
% true.

% ?- my_append([1, 2], [3, 4, 5], R).
% R = [1, 2, 3, 4, 5].

% ?- my_append([1, 2], [3, 4], R).
% R = [1, 2, 3, 4].