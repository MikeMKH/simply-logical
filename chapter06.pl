% 6.1

merge([], Ys, Ys).
merge(Xs, [], Xs).
merge([X|Xs], [Y|Ys], [X|Zs]) :-
  X =< Y,
  merge(Xs, [Y|Ys], Zs).
merge([X|Xs], [Y|Ys], [Y|Zs]) :-
  X > Y,
  merge([X|Xs], Ys, Zs).

% ?- merge([1, 2, 3], [4, 5], L).
% L = [1, 2, 3, 4, 5] ;
% false.

% ?- merge([], [4, 5], L).
% L = [4, 5] ;
% false.

% ?- merge([1, 2, 3], [], L).
% L = [1, 2, 3] ;
% false.

% ?- merge([1, 4, 5, 8], [2, 3, 6, 7], L).
% L = [1, 2, 3, 4, 5, 6, 7, 8] .

% ?- merge([1, 4, 5, 8], [1, 2, 3, 6, 7], L).
% L = [1, 1, 2, 3, 4, 5, 6, 7, 8] .

% 6.2

leftOf(Pos, Values, LeftOf) :-
  nth1(Pos, Values, Pivot),
  include({Pivot}/[X]>>(X =< Pivot), Values, LeftOf).

% ?- leftOf(1, [3, 1, 2, -1, 4, 5, 0, 6], L).
% L = [3, 1, 2, -1, 0].

% ?- leftOf(1, [3, 4, 5, 6], L).
% L = [3].

% ?- leftOf(1, [], L).
% false.

% ?- leftOf(3, [1, 2, 3, 4, 5, 6], L).
% L = [1, 2, 3].

