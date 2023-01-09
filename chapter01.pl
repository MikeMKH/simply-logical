% 1. A brief introduction to clausal logic

connected(bond_street,oxford_circus,central).
connected(oxford_circus,piccadilly_circus,bakerloo).
connected(oxford_circus,tottenham_court_road,central).
connected(bond_street,green_park,jubilee).
connected(green_park,charing_cross,jubilee).
connected(green_park,piccadilly_circus,piccadilly).
connected(piccadilly_circus,leicester_square,piccadilly).
connected(green_park,oxford_circus,victoria).
connected(piccadilly_circus,charing_cross,bakerloo).
connected(tottenham_court_road,leicester_square,northern).
connected(leicester_square,charing_cross,northern).

nearby(X,Y):-connected(X,Y,_L).
nearby(X,Y):-connected(X,Z,L),connected(Z,Y,L).

% ?- nearby(bond_street, R).
% R = oxford_circus ;
% R = green_park ;
% R = tottenham_court_road ;
% R = charing_cross ;
% false.

% ex 1.1

not_too_far(X,Y):-nearby(X,Y).
not_too_far(X,Y):-connected(X,Z,_L1),connected(Z,Y,_L2).
not_too_far(X,Y):-connected(X,Y1,L),connected(Y1,Y2,L),connected(Y2,Y,L).
not_too_far(X,Y):-connected(X,Y1,_L1),connected(Y1,Y2,L2),connected(Y2,Y,L2).

% ?- not_too_far(bond_street, charing_cross).
% true .

% ?- nearby(bond_street, piccadilly_circus).
% false.

% ?- not_too_far(bond_street, piccadilly_circus).
% true .

% ex 1.2

% [trace]  ?- nearby(W,charing_cross).
%    Call: (10) nearby(_8444, charing_cross) ? creep
%    Call: (11) connected(_8444, charing_cross, _9696) ? creep
%    Exit: (11) connected(green_park, charing_cross, jubilee) ? creep
%    Exit: (10) nearby(green_park, charing_cross) ? creep
% W = green_park .

% [trace]  ?- not_too_far(bond_street, piccadilly_circus).
%    Call: (10) not_too_far(bond_street, piccadilly_circus) ? creep
%    Call: (11) nearby(bond_street, piccadilly_circus) ? creep
%    Call: (12) connected(bond_street, piccadilly_circus, _16072) ? creep
%    Fail: (12) connected(bond_street, piccadilly_circus, _16830) ? creep
%    Redo: (11) nearby(bond_street, piccadilly_circus) ? creep
%    Call: (12) connected(bond_street, _18282, _18284) ? creep
%    Exit: (12) connected(bond_street, oxford_circus, central) ? creep
%    Call: (12) connected(oxford_circus, piccadilly_circus, central) ? creep
%    Fail: (12) connected(oxford_circus, piccadilly_circus, central) ? creep
%    Redo: (12) connected(bond_street, _18282, _18284) ? creep
%    Exit: (12) connected(bond_street, green_park, jubilee) ? creep
%    Call: (12) connected(green_park, piccadilly_circus, jubilee) ? creep
%    Fail: (12) connected(green_park, piccadilly_circus, jubilee) ? creep
%    Fail: (11) nearby(bond_street, piccadilly_circus) ? creep
%    Redo: (10) not_too_far(bond_street, piccadilly_circus) ? creep
%    Call: (11) connected(bond_street, _25858, _25920) ? creep
%    Exit: (11) connected(bond_street, oxford_circus, central) ? creep
%    Call: (11) connected(oxford_circus, piccadilly_circus, _27436) ? creep
%    Exit: (11) connected(oxford_circus, piccadilly_circus, bakerloo) ? creep
%    Exit: (10) not_too_far(bond_street, piccadilly_circus) ? creep
% true .

% ex 1.3

reachable(X,Y):-connected(X,Y,_L).
reachable(X,Y):-connected(X,Z,_L),reachable(Z,Y).

% [trace]  ?- reachable(bond_street,W).
%    Call: (10) reachable(bond_street, _10518) ? creep
%    Call: (11) connected(bond_street, _10518, _11768) ? creep
%    Exit: (11) connected(bond_street, oxford_circus, central) ? creep
%    Exit: (10) reachable(bond_street, oxford_circus) ? creep
% W = oxford_circus .

% [trace]  ?- reachable(bond_street,leicester_square).
%    Call: (10) reachable(bond_street, leicester_square) ? creep
%    Call: (11) connected(bond_street, leicester_square, _39712) ? creep
%    Fail: (11) connected(bond_street, leicester_square, _40470) ? creep
%    Redo: (10) reachable(bond_street, leicester_square) ? creep
%    Call: (11) connected(bond_street, _41922, _41984) ? creep
%    Exit: (11) connected(bond_street, oxford_circus, central) ? creep
%    Call: (11) reachable(oxford_circus, leicester_square) ? creep
%    Call: (12) connected(oxford_circus, leicester_square, _44254) ? creep
%    Fail: (12) connected(oxford_circus, leicester_square, _45012) ? creep
%    Redo: (11) reachable(oxford_circus, leicester_square) ? creep
%    Call: (12) connected(oxford_circus, _46464, _46526) ? creep
%    Exit: (12) connected(oxford_circus, piccadilly_circus, bakerloo) ? creep
%    Call: (12) reachable(piccadilly_circus, leicester_square) ? creep
%    Call: (13) connected(piccadilly_circus, leicester_square, _48796) ? creep
%    Exit: (13) connected(piccadilly_circus, leicester_square, piccadilly) ? creep
%    Exit: (12) reachable(piccadilly_circus, leicester_square) ? creep
%    Exit: (11) reachable(oxford_circus, leicester_square) ? creep
%    Exit: (10) reachable(bond_street, leicester_square) ? creep
% true .

reachable1(X,Y,noroute):-connected(X,Y,_L).
reachable1(X,Y,route(Z,R)):-connected(X,Z,_L),reachable1(Z,Y,R).
                          
% ?- reachable1(oxford_circus,charing_cross,R).
% R = route(piccadilly_circus, noroute) ;
% R = route(piccadilly_circus, route(leicester_square, noroute)) ;
% R = route(tottenham_court_road, route(leicester_square, noroute)) ;
% false.

% ex 1.4
islist([]).
islist([_|T]):-islist(T).

% ?- islist([]).
% true.

% ?- islist([1]).
% true.

% ?- islist([1,2]).
% true.

% ?- islist(mike).
% false.

% ?- islist(route(a,b)).
% false.

reachable2(X,Y,[]):-connected(X,Y,_L).
reachable2(X,Y,[Z|R]):-connected(X,Z,_L),reachable2(Z,Y,R).

% ?- reachable2(oxford_circus,charing_cross,R).
% R = [piccadilly_circus] ;
% R = [piccadilly_circus, leicester_square] ;
% R = [tottenham_court_road, leicester_square] ;
% false.

% ex 1.5

% ?- reachable2(bond_street,piccadilly_circus,[A,B|R]).
% A = green_park,
% B = oxford_circus,
% R = [] ;
% false.