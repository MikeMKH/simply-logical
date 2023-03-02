% https://book.simply-logical.space/src/text/appendices/a_2.html

% element(X,Ys) <- X is an element of the list Ys
element(X,[X|Ys]).
element(X,[Y|Ys]):-
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
  inducible((flies(X):-true)).

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