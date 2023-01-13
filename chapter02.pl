% 2. Clausal logic and resolution

% 2.1 tip https://book.simply-logical.space/src/text/1_part_i/2.1.html
prop_atom(married).
prop_atom(bachelor).
prop_atom(man).
prop_atom(adult).

% Propositional atoms are trivially ground
ground_atom(A):-prop_atom(A).

% ?- ground_atom(X).
% X = married ;
% X = bachelor ;
% X = man ;
% X = adult.

% 2.2 example https://book.simply-logical.space/src/text/1_part_i/2.2.html#ex-2-7
likes(peter,maria):-follows(maria,C),teaches(peter,C).
likes(peter,S):-student_of(S,peter).
student_of(maria,peter).

% ?- likes(peter, S).
% S = maria ;
% S = maria ;
% S = maria.

% 2.7
follows(maria, lambda_calculus).
teaches(peter, lambda_calculus).

teaches(peter,C):-first_year_course(C).
first_year_course(lambda_calculus).

% ?- teaches(peter, C).
% C = lambda_calculus ;
% C = lambda_calculus.

% ?- foreach(first_year_course(C), teaches(T, C)).
% T = peter ;
% T = peter.

% 2.9
:- discontiguous likes/2.
:- discontiguous student_of/2.
:- discontiguous teaches/2.
:- discontiguous follows/2.

likes(peter,S):-student_of(S,peter).
likes(peter,Y):-likes(peter,X),likes(X,Y).
likes(maria,paul).
student_of(S,T):-follows(S,C),teaches(T,C).
teaches(peter,ai_techniques).
follows(maria,ai_techniques).

% [trace]  ?- N=paul,likes(peter,N).
%    Call: (11) _24542=paul ? creep
%    Exit: (11) paul=paul ? creep
%    Call: (11) likes(peter, paul) ? creep
%    Call: (12) student_of(paul, peter) ? creep
%    Call: (13) follows(paul, _28130) ? creep
%    Fail: (13) follows(paul, _28130) ? creep
%    Fail: (12) student_of(paul, peter) ? creep
%    Redo: (11) likes(peter, paul) ? creep
%    Call: (12) student_of(paul, peter) ? creep
%    Call: (13) follows(paul, _31902) ? creep
%    Fail: (13) follows(paul, _31902) ? creep
%    Fail: (12) student_of(paul, peter) ? creep
%    Redo: (11) likes(peter, paul) ? creep
%    Call: (12) likes(peter, _34920) ? creep
%    Call: (13) follows(maria, _35676) ? creep
%    Exit: (13) follows(maria, lambda_calculus) ? creep
%    Call: (13) teaches(peter, lambda_calculus) ? creep
%    Exit: (13) teaches(peter, lambda_calculus) ? creep
%    Exit: (12) likes(peter, maria) ? creep
%    Call: (12) likes(maria, paul) ? creep
%    Exit: (12) likes(maria, paul) ? creep
%    Exit: (11) likes(peter, paul) ? creep
% N = paul .

maximum(X,Y,max(X,Y)):-number(X),number(Y).

% ?- maximum(11, 12, R).
% R = max(11, 12).

% ?- maximum(foo, bar, R).
% false.

add(0,X,X).
add(s(X),Y,s(Z)):-add(X,Y,Z).

% ?- add(s(s(0)),s(0),R).
% R = s(s(s(0))).

% ?- add(X,s(s(0)),s(s(s(s(0))))).
% X = s(s(0)) .

% ?- add(X,Y,s(s(s(0)))).
% X = 0,
% Y = s(s(s(0))) ;
% X = s(0),
% Y = s(s(0)) ;
% X = s(s(0)),
% Y = s(0) ;
% X = s(s(s(0))),
% Y = 0 ;
% false.

listlength([],0).
listlength([_H|T],s(L)):-listlength(T,L).

% ?- listlength([1,2,3],R).
% R = s(s(s(0))).

% ?- listlength([1],R).
% R = s(0).

% ?- listlength(L,s(s(0))).
% L = [_, _].

% ?- listlength([H|T],s(s(0))).
% T = [_].