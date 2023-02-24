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