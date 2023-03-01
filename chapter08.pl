% 8.1

bird(sal).
bird(tweety).
ostrich(tweety).
flies(X):-bird(X),\+ abnormal(X).
abnormal(X):-ostrich(X).

% ?- flies(X).
% X = sal ;
% false.

% ?- flies(tweety).
% false.

% https://book.simply-logical.space/src/text/3_part_iii/8.3.html

:- discontiguous (xor)/3.
:- discontiguous and/3.
:- discontiguous or/3.

adder(X,Y,Z,Sum,Carry):-
  xor(X,Y,S),
  xor(Z,S,Sum),
  and(X,Y,C1),
  and(Z,S,C2),
  or(C1,C2,Carry).

xor(0,0,0).        and(0,0,0).        or(0,0,0).
xor(0,1,1).        and(0,1,0).        or(0,1,1).
xor(1,0,1).        and(1,0,0).        or(1,0,1).
xor(1,1,0).        and(1,1,1).        or(1,1,1).

% ?- adder(1,0,0,Sum,Carry).
% Sum = 1,
% Carry = 0 .

% ?- adder(X,Y,Z,1,1).
% X = Y, Y = Z, Z = 1 ;
% false.

% ?- adder(X,Y,0,1,1).
% false.

% ?- adder(X,Y,1,1,1).
% X = Y, Y = 1 ;
% false.

% ?- adder(X,Y,Z,1,0).
% X = Y, Y = 0,
% Z = 1 ;
% X = Z, Z = 0,
% Y = 1 ;
% X = 1,
% Y = Z, Z = 0 ;
% false.

% ?- adder(X,Y,Z,0,1).
% X = 0,
% Y = Z, Z = 1 ;
% X = Z, Z = 1,
% Y = 0 ;
% X = Y, Y = 1,
% Z = 0 ;
% false.