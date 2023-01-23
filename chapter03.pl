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

% 3.4

red_cut_max(M, N, M) :- M >= N, !.
red_cut_max(_M, N, N).

% [trace]  ?- red_cut_max(1, 1, M).
%    Call: (10) red_cut_max(1, 1, _210682) ? creep
%    Call: (11) 1>=1 ? creep
%    Exit: (11) 1>=1 ? creep
%    Exit: (10) red_cut_max(1, 1, 1) ? creep
% M = 1.

% [trace]  ?- red_cut_max(0, 1, M).
%    Call: (10) red_cut_max(0, 1, _215746) ? creep
%    Call: (11) 0>=1 ? creep
%    Fail: (11) 0>=1 ? creep
%    Redo: (10) red_cut_max(0, 1, _215746) ? creep
%    Exit: (10) red_cut_max(0, 1, 1) ? creep
% M = 1.

% [trace]  ?- red_cut_max(M, 1, 2).
%    Call: (10) red_cut_max(_221562, 1, 2) ? creep
%    Call: (11) 2>=1 ? creep
%    Exit: (11) 2>=1 ? creep
%    Exit: (10) red_cut_max(2, 1, 2) ? creep
% M = 2.

% [trace]  ?- red_cut_max(1, M, 2).
%    Call: (10) red_cut_max(1, _226632, 2) ? creep
%    Exit: (10) red_cut_max(1, 2, 2) ? creep
% M = 2.

% [trace]  ?- red_cut_max(1, M, M).
%    Call: (10) red_cut_max(1, _230188, _230188) ? creep
%    Call: (11) 1>=1 ? creep
%    Exit: (11) 1>=1 ? creep
%    Exit: (10) red_cut_max(1, 1, 1) ? creep
% M = 1.

% [trace]  ?- red_cut_max(M, 1,  M).
%    Call: (10) red_cut_max(_235250, 1, _235250) ? creep
%    Call: (11) _235250>=1 ? creep
% ERROR: Arguments are not sufficiently instantiated
% ERROR: In:
% ERROR:   [11] _237674>=1
% ERROR:   [10] red_cut_max(_237700,1,_237704) at /Users/mike/Kata/simply-logical/chapter03.pl:106
% ERROR:    [9] toplevel_call(user:user: ...) at /usr/local/Cellar/swi-prolog/8.4.3_1/libexec/lib/swipl/boot/toplevel.pl:1158
%    Exception: (11) _235250>=1 ? creep
%    Exception: (10) red_cut_max(_235250, 1, _235250) ? creep

% 3.5

wrong_bachelor(X):-not(married(X)),man(X).
man(fred).
man(peter).
married(fred).

% [trace]  ?- wrong_bachelor(fred).
%    Call: (10) wrong_bachelor(fred) ? creep
% ^  Call: (11) not(married(fred)) ? creep
%    Call: (12) married(fred) ? creep
%    Exit: (12) married(fred) ? creep
% ^  Fail: (11) not(user:married(fred)) ? creep
%    Fail: (10) wrong_bachelor(fred) ? creep
% false.

% [trace]  ?- wrong_bachelor(peter).
%    Call: (10) wrong_bachelor(peter) ? creep
% ^  Call: (11) not(married(peter)) ? creep
%    Call: (12) married(peter) ? creep
%    Fail: (12) married(peter) ? creep
% ^  Exit: (11) not(user:married(peter)) ? creep
%    Call: (11) man(peter) ? creep
%    Exit: (11) man(peter) ? creep
%    Exit: (10) wrong_bachelor(peter) ? creep
% true.

% [trace]  ?- wrong_bachelor(X).
%    Call: (10) wrong_bachelor(_21978) ? creep
% ^  Call: (11) not(married(_21978)) ? creep
%    Call: (12) married(_21978) ? creep
%    Exit: (12) married(fred) ? creep
% ^  Fail: (11) not(user:married(_21978)) ? creep
%    Fail: (10) wrong_bachelor(_21978) ? creep
% false.

% 3.6
:- discontiguous man/1.
:- discontiguous married/1.

bachelor(X):-man(X),not(married(X)).
man(fred).
man(peter).
married(fred).

% ?- bachelor(X).
% X = peter .

% ?- wrong_bachelor(X).
% false.