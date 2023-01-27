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

% 3.7

p1:-q1,r1,s1,!,t1.
p1:-q1,r1,u1.
q1.
r1.
u1.
s1:-false.
t1.

% [trace]  ?- p1.
%    Call: (10) p1 ? creep
%    Call: (11) q1 ? creep
%    Exit: (11) q1 ? creep
%    Call: (11) r1 ? creep
%    Exit: (11) r1 ? creep
%    Call: (11) s1 ? creep
%    Call: (12) false ? creep
%    Fail: (12) false ? creep
%    Fail: (11) s1 ? creep
%    Redo: (10) p1 ? creep
%    Call: (11) q1 ? creep
%    Exit: (11) q1 ? creep
%    Call: (11) r1 ? creep
%    Exit: (11) r1 ? creep
%    Call: (11) u1 ? creep
%    Exit: (11) u1 ? creep
%    Exit: (10) p1 ? creep
% true.

% 3.8

p2:-q2,r2,if_s_then_t_else_u.
if_s_then_t_else_u:-s2,!,t2.
if_s_then_t_else_u:-u2.
q2.
r2.
u2.
s2:-false.
t2:-true.

% [trace]  ?- p2.
%    Call: (10) p2 ? creep
%    Call: (11) q2 ? creep
%    Exit: (11) q2 ? creep
%    Call: (11) r2 ? creep
%    Exit: (11) r2 ? creep
%    Call: (11) if_s_then_t_else_u ? creep
%    Call: (12) s2 ? creep
%    Call: (13) false ? creep
%    Fail: (13) false ? creep
%    Fail: (12) s2 ? creep
%    Redo: (11) if_s_then_t_else_u ? creep
%    Call: (12) u2 ? creep
%    Exit: (12) u2 ? creep
%    Exit: (11) if_s_then_t_else_u ? creep
%    Exit: (10) p2 ? creep
% true.

p3:-q3,r3,s3->t3;u3.
q3.
r3.
u3.
s3:-false.
t3:-true.

% [trace]  ?- p3.
%    Call: (10) p3 ? creep
%    Call: (11) q3 ? creep
%    Exit: (11) q3 ? creep
%    Call: (11) r3 ? creep
%    Exit: (11) r3 ? creep
%    Call: (11) s3 ? creep
%    Call: (12) false ? creep
%    Fail: (12) false ? creep
%    Fail: (11) s3 ? creep
%    Redo: (10) p3 ? creep
%    Call: (11) u3 ? creep
%    Exit: (11) u3 ? creep
%    Exit: (10) p3 ? creep
% true.

% 3.9

% ax^2 + bx + c = 0
zero(A,B,C,X) :-
  X is (-B + sqrt(B*B - 4*A*C)) / 2*A.
zero(A,B,C,X) :-
  X is (-B - sqrt(B*B - 4*A*C)) / 2*A.

% ?- zero(3, 2, -1, X).
% X = 3.0 ;
% X = -9.0.

% ?- zero(3, 1, -6, X).
% X = 11.316005617976295 ;
% X = -14.316005617976295.

nat(0).
nat(s(X)):-nat(X).

add(0,X,X).
add(s(X),Y,s(Z)):-add(X,Y,Z).

% ?- add(s(0), s(s(0)), Three).
% Three = s(s(s(0))).

% ?- add(One, s(s(0)), s(s(s(0)))).
% One = s(0) ;
% false.

% [trace]  ?- add(s(s(0)), s(0), X).
%    Call: (10) add(s(s(0)), s(0), _27998) ? creep
%    Call: (11) add(s(0), s(0), _29238) ? creep
%    Call: (12) add(0, s(0), _30000) ? creep
%    Exit: (12) add(0, s(0), s(0)) ? creep
%    Exit: (11) add(s(0), s(0), s(s(0))) ? creep
%    Exit: (10) add(s(s(0)), s(0), s(s(s(0)))) ? creep
% X = s(s(s(0))).

mul(0,_X,0).
mul(s(X),Y,Z):-mul(X,Y,Z1),add(Y,Z1,Z).

% ?- mul(s(0), s(s(0)), Two).
% Two = s(s(0)).

% ?- mul(s(0), Two, s(s(0))).
% Two = s(s(0)) ;
% false.

% [trace]  ?- mul(s(s(0)), s(0), X).
%    Call: (10) mul(s(s(0)), s(0), _35836) ? creep
%    Call: (11) mul(s(0), s(0), _37080) ? creep
%    Call: (12) mul(0, s(0), _37840) ? creep
%    Exit: (12) mul(0, s(0), 0) ? creep
%    Call: (12) add(s(0), 0, _37080) ? creep
%    Call: (13) add(0, 0, _40118) ? creep
%    Exit: (13) add(0, 0, 0) ? creep
%    Exit: (12) add(s(0), 0, s(0)) ? creep
%    Exit: (11) mul(s(0), s(0), s(0)) ? creep
%    Call: (11) add(s(0), s(0), _35836) ? creep
%    Call: (12) add(0, s(0), _43912) ? creep
%    Exit: (12) add(0, s(0), s(0)) ? creep
%    Exit: (11) add(s(0), s(0), s(s(0))) ? creep
%    Exit: (10) mul(s(s(0)), s(0), s(s(0))) ? creep
% X = s(s(0)).

% 3.10

naive_length([], 0).
naive_length([_|T], L) :-
  naive_length(T, L1),
  L is L1 + 1.

%   [trace]  ?- naive_length([], X).
% Call: (10) naive_length([], _62308) ? creep
% Exit: (10) naive_length([], 0) ? creep
% X = 0.

% [trace]  ?- naive_length([1,2], X).
% Call: (10) naive_length([1, 2], _65862) ? creep
% Call: (11) naive_length([2], _67098) ? creep
% Call: (12) naive_length([], _67854) ? creep
% Exit: (12) naive_length([], 0) ? creep
% Call: (12) _67098 is 0+1 ? creep
% Exit: (12) 1 is 0+1 ? creep
% Exit: (11) naive_length([2], 1) ? creep
% Call: (11) _65862 is 1+1 ? creep
% Exit: (11) 2 is 1+1 ? creep
% Exit: (10) naive_length([1, 2], 2) ? creep
% X = 2.

% 3.11

acc_length(L, N) :- acc_length(L, 0, N).
acc_length([], N, N).
acc_length([_|T], N0, N) :-
  N1 is N0 + 1,
  acc_length(T, N1, N).

% [trace]  ?- acc_length([], X).
% Call: (10) acc_length([], _85194) ? creep
% Call: (11) acc_length([], 0, _85194) ? creep
% Exit: (11) acc_length([], 0, 0) ? creep
% Exit: (10) acc_length([], 0) ? creep
% X = 0.

% [trace]  ?- acc_length([1, 2], X).
% Call: (10) acc_length([1, 2], _90264) ? creep
% Call: (11) acc_length([1, 2], 0, _90264) ? creep
% Call: (12) _92264 is 0+1 ? creep
% Exit: (12) 1 is 0+1 ? creep
% Call: (12) acc_length([2], 1, _90264) ? creep
% Call: (13) _94538 is 1+1 ? creep
% Exit: (13) 2 is 1+1 ? creep
% Call: (13) acc_length([], 2, _90264) ? creep
% Exit: (13) acc_length([], 2, 2) ? creep
% Exit: (12) acc_length([2], 1, 2) ? creep
% Exit: (11) acc_length([1, 2], 0, 2) ? creep
% Exit: (10) acc_length([1, 2], 2) ? creep
% X = 2.

% 3.12

naive_reverse([], []).
naive_reverse([H|T], R) :-
  naive_reverse(T, R1),
  append(R1, [H], R).

% [trace]  ?- naive_reverse([], R).
% Call: (10) naive_reverse([], _108162) ? creep
% Exit: (10) naive_reverse([], []) ? creep
% R = [].

% [trace]  ?- naive_reverse([1,2,3], R).
% Call: (10) naive_reverse([1, 2, 3], _111726) ? creep
% Call: (11) naive_reverse([2, 3], _112980) ? creep
% Call: (12) naive_reverse([3], _113736) ? creep
% Call: (13) naive_reverse([], _114492) ? creep
% Exit: (13) naive_reverse([], []) ? creep
% Call: (13) lists:append([], [3], _113736) ? creep
% Exit: (13) lists:append([], [3], [3]) ? creep
% Exit: (12) naive_reverse([3], [3]) ? creep
% Call: (12) lists:append([3], [2], _112980) ? creep
% Exit: (12) lists:append([3], [2], [3, 2]) ? creep
% Exit: (11) naive_reverse([2, 3], [3, 2]) ? creep
% Call: (11) lists:append([3, 2], [1], _111726) ? creep
% Exit: (11) lists:append([3, 2], [1], [3, 2, 1]) ? creep
% Exit: (10) naive_reverse([1, 2, 3], [3, 2, 1]) ? creep
% R = [3, 2, 1].

% 3.13

dl_reverse(X, Y):- dl_rev_aux(X, Y-[]).

dl_rev_aux([], Y-Y).
dl_rev_aux([H|T], Y-Y0):- dl_rev_aux(T, Y-[H|Y0]).

% [trace]  ?- dl_reverse([], X).
%    Call: (10) dl_reverse([], _14796) ? creep
%    Call: (11) dl_rev_aux([], _14796-[]) ? creep
%    Exit: (11) dl_rev_aux([], []-[]) ? creep
%    Exit: (10) dl_reverse([], []) ? creep
% X = [].

% [trace]  ?- dl_reverse([1, 2, 3], X).
%    Call: (10) dl_reverse([1, 2, 3], _19856) ? creep
%    Call: (11) dl_rev_aux([1, 2, 3], _19856-[]) ? creep
%    Call: (12) dl_rev_aux([2, 3], _19856-[1]) ? creep
%    Call: (13) dl_rev_aux([3], _19856-[2, 1]) ? creep
%    Call: (14) dl_rev_aux([], _19856-[3, 2, 1]) ? creep
%    Exit: (14) dl_rev_aux([], [3, 2, 1]-[3, 2, 1]) ? creep
%    Exit: (13) dl_rev_aux([3], [3, 2, 1]-[2, 1]) ? creep
%    Exit: (12) dl_rev_aux([2, 3], [3, 2, 1]-[1]) ? creep
%    Exit: (11) dl_rev_aux([1, 2, 3], [3, 2, 1]-[]) ? creep
%    Exit: (10) dl_reverse([1, 2, 3], [3, 2, 1]) ? creep
% X = [3, 2, 1].

% 3.14

rel(_R,[],[]).
rel(R,[X|Xs],[Y|Ys]):-
    F =.. [R, X, Y],
    call(F),
    rel(R,Xs,Ys).
  
% ?- Add=..[plus, 1, 2, Z],call(Add).
% Add = plus(1, 2, 3),
% Z = 3.

parent(john,peter).
parent(john,paul).
parent(john,mary).
parent(mick,davy).
parent(mick,dee).
parent(mick,dozy).

parent(mike,lily).
parent(kelsey,lily).

% ?- parent(john,X).
% X = peter ;
% X = paul ;
% X = mary.

% ?- rel(parent,[mike],[lily]).
% true .

% ?- rel(parent,[mike,kelsey,mick],[lily,lily,peter]).
% false.

% ?- rel(parent,[mike,kelsey],[lily,lily]).
% true .

parents(Ps,Cs):-rel(parent,Ps,Cs).

% ?- parents(X,[lily]).
% X = [mike] ;
% X = [kelsey] ;
% false.

% ?- parents(X,[lily,peter]).
% X = [mike, john] ;
% X = [kelsey, john] ;
% false.

children1(Parent,Children):-
  findall(C,parent(Parent,C),Children).

% ?- children1(mike,X).
% X = [lily].

% ?- children1(X,lily).
% false.

% ?- children1(john,X).
% X = [peter, paul, mary].

% ?- bagof(C,parent(P,C),L).
% P = john,
% L = [peter, paul, mary] ;
% P = kelsey,
% L = [lily] ;
% P = mick,
% L = [davy, dee, dozy] ;
% P = mike,
% L = [lily].

% ?- bagof(C,P^parent(P,C),L).
% L = [peter, paul, mary, davy, dee, dozy, lily, lily].

children2(Parent,Children):-
  bagof(C,parent(Parent,C),Children).

% ?- children2(john,X).
% X = [peter, paul, mary].

% ?- children1(X,[lily]).
% false.

% ?- children2(X,[lily]).
% X = kelsey ;
% X = mike.

% 3.15

dedup(L, R) :-
  setof(X,element(X,L),R).
element(X,[X|_]).
element(X,[_|Y]) :- element(X,Y).

% ?- dedup([1,2,1,2,3,1,4],R).
% R = [1, 2, 3, 4].

% ?- dedup([],R).
% false.

% ?- dedup([1],R).
% R = [1].

% [trace]  ?- dedup([1,2,1],R).
%    Call: (10) dedup([1, 2, 1], _22780) ? creep
% ^  Call: (11) setof(_24026, element(_24026, [1, 2, 1]), _22780) ? creep
%    Call: (17) element(_24026, [1, 2, 1]) ? creep
%    Exit: (17) element(1, [1, 2, 1]) ? creep
%    Redo: (17) element(_24026, [1, 2, 1]) ? creep
%    Call: (18) element(_24026, [2, 1]) ? creep
%    Exit: (18) element(2, [2, 1]) ? creep
%    Exit: (17) element(2, [1, 2, 1]) ? creep
%    Redo: (18) element(_24026, [2, 1]) ? creep
%    Call: (19) element(_24026, [1]) ? creep
%    Exit: (19) element(1, [1]) ? creep
%    Exit: (18) element(1, [2, 1]) ? creep
%    Exit: (17) element(1, [1, 2, 1]) ? creep
%    Redo: (19) element(_24026, [1]) ? creep
%    Call: (20) element(_24026, []) ? creep
%    Fail: (20) element(_24026, []) ? creep
%    Fail: (19) element(_24026, [1]) ? creep
%    Fail: (18) element(_24026, [2, 1]) ? creep
%    Fail: (17) element(_24026, [1, 2, 1]) ? creep
% ^  Exit: (11) setof(_24026, user:element(_24026, [1, 2, 1]), [1, 2]) ? creep
%    Exit: (10) dedup([1, 2, 1], [1, 2]) ? creep
% R = [1, 2].

% [trace]  ?- element(X,[1,2,1]).
%    Call: (10) element(_41350, [1, 2, 1]) ? creep
%    Exit: (10) element(1, [1, 2, 1]) ? creep
% X = 1 ;
%    Redo: (10) element(_41350, [1, 2, 1]) ? creep
%    Call: (11) element(_41350, [2, 1]) ? creep
%    Exit: (11) element(2, [2, 1]) ? creep
%    Exit: (10) element(2, [1, 2, 1]) ? creep
% X = 2 ;
%    Redo: (11) element(_41350, [2, 1]) ? creep
%    Call: (12) element(_41350, [1]) ? creep
%    Exit: (12) element(1, [1]) ? creep
%    Exit: (11) element(1, [2, 1]) ? creep
%    Exit: (10) element(1, [1, 2, 1]) ? creep
% X = 1 ;
%    Redo: (12) element(_41350, [1]) ? creep
%    Call: (13) element(_41350, []) ? creep
%    Fail: (13) element(_41350, []) ? creep
%    Fail: (12) element(_41350, [1]) ? creep
%    Fail: (11) element(_41350, [2, 1]) ? creep
%    Fail: (10) element(_41350, [1, 2, 1]) ? creep
% false.