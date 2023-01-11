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