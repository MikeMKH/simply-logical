% 3. Logic Programming and Prolog

% 3.1

student_of(X,T):-follows(X,C),teaches(T,C).
follows(paul,computer_science).
follows(paul,expert_systems).
follows(maria,ai_techniques).
teaches(adrian,expert_systems).
teaches(peter,ai_techniques).
teaches(peter,computer_science).

% [trace]  ?- follows(S,C),teaches(peter,C).
%    Call: (11) follows(_45872, _45874) ? creep
%    Exit: (11) follows(paul, computer_science) ? creep
%    Call: (11) teaches(peter, computer_science) ? creep
%    Exit: (11) teaches(peter, computer_science) ? creep
% S = paul,
% C = computer_science ;
%    Redo: (11) follows(_45872, _45874) ? creep
%    Exit: (11) follows(paul, expert_systems) ? creep
%    Call: (11) teaches(peter, expert_systems) ? creep
%    Fail: (11) teaches(peter, expert_systems) ? creep
%    Redo: (11) follows(_45872, _45874) ? creep
%    Exit: (11) follows(maria, ai_techniques) ? creep
%    Call: (11) teaches(peter, ai_techniques) ? creep
%    Exit: (11) teaches(peter, ai_techniques) ? creep
% S = maria,
% C = ai_techniques .

% 3.2

list([]).
list([_H|T]):-list(T).

% [trace]  ?- list(L).
%    Call: (10) list(_73774) ? creep
%    Exit: (10) list([]) ? creep
% L = [] ;
%    Redo: (10) list(_73774) ? creep
%    Call: (11) list(_77816) ? creep
%    Exit: (11) list([]) ? creep
%    Exit: (10) list([_77814]) ? creep
% L = [_] ;
%    Redo: (11) list(_77816) ? creep
%    Call: (12) list(_82176) ? creep
%    Exit: (12) list([]) ? creep
%    Exit: (11) list([_82174]) ? creep
%    Exit: (10) list([_77814, _82174]) ? creep
% L = [_, _] ;
%    Redo: (12) list(_82176) ? creep
%    Call: (13) list(_87296) ? creep
%    Exit: (13) list([]) ? creep
%    Exit: (12) list([_87294]) ? creep
%    Exit: (11) list([_82174, _87294]) ? creep
%    Exit: (10) list([_77814, _82174, _87294]) ? creep
% L = [_, _, _] .

% 3.3

:- discontiguous likes/2.
:- discontiguous student_of/2.

likes(peter,Y):-friendly(Y).
likes(T,S):-student_of(S,T).
student_of(maria,peter).
student_of(paul,peter).
friendly(maria).

% [trace]  ?- likes(A,B).
%    Call: (10) likes(_103726, _103728) ? creep
%    Call: (11) friendly(_103728) ? creep
%    Exit: (11) friendly(maria) ? creep
%    Exit: (10) likes(peter, maria) ? creep
% A = peter,
% B = maria ;
%    Redo: (10) likes(_103726, _103728) ? creep
%    Call: (11) student_of(_103728, _103726) ? creep
%    Call: (12) follows(_103728, _110456) ? creep
%    Exit: (12) follows(paul, computer_science) ? creep
%    Call: (12) teaches(_103726, computer_science) ? creep
%    Exit: (12) teaches(peter, computer_science) ? creep
%    Exit: (11) student_of(paul, peter) ? creep
%    Exit: (10) likes(peter, paul) ? creep
% A = peter,
% B = paul ;
%    Redo: (12) follows(_103728, _110456) ? creep
%    Exit: (12) follows(paul, expert_systems) ? creep
%    Call: (12) teaches(_103726, expert_systems) ? creep
%    Exit: (12) teaches(adrian, expert_systems) ? creep
%    Exit: (11) student_of(paul, adrian) ? creep
%    Exit: (10) likes(adrian, paul) ? creep
% A = adrian,
% B = paul ;
%    Redo: (12) teaches(_103726, expert_systems) ? creep
%    Fail: (12) teaches(_103726, expert_systems) ? creep
%    Redo: (12) follows(_103728, _110456) ? creep
%    Exit: (12) follows(maria, ai_techniques) ? creep
%    Call: (12) teaches(_103726, ai_techniques) ? creep
%    Exit: (12) teaches(peter, ai_techniques) ? creep
%    Exit: (11) student_of(maria, peter) ? creep
%    Exit: (10) likes(peter, maria) ? creep
% A = peter,
% B = maria .