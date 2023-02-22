% 7.1

sentence             --> noun_phrase,verb_phrase.
noun_phrase          --> proper_noun.
noun_phrase          --> article,adjective,noun.
noun_phrase          --> article,noun.
verb_phrase          --> intransitive_verb.
verb_phrase          --> transitive_verb,noun_phrase.
article              --> [the].
adjective            --> [lazy].
adjective            --> [rapid].
proper_noun          --> [achilles].
noun                 --> [turtle].
intransitive_verb    --> [sleeps].
transitive_verb      --> [beats].

% ?- phrase(sentence, S).
% S = [achilles, sleeps] ;
% S = [achilles, beats, achilles] ;
% S = [achilles, beats, the, lazy, turtle] ;
% S = [achilles, beats, the, rapid, turtle] ;
% S = [achilles, beats, the, turtle] ;
% S = [the, lazy, turtle, sleeps] ;
% S = [the, lazy, turtle, beats, achilles] ;
% S = [the, lazy, turtle, beats, the, lazy, turtle] ;
% S = [the, lazy, turtle, beats, the, rapid, turtle] ;
% S = [the, lazy, turtle, beats, the, turtle] ;
% S = [the, rapid, turtle, sleeps] ;
% S = [the, rapid, turtle, beats, achilles] ;
% S = [the, rapid, turtle, beats, the, lazy, turtle] ;
% S = [the, rapid, turtle, beats, the, rapid, turtle] ;
% S = [the, rapid, turtle, beats, the, turtle] ;
% S = [the, turtle, sleeps] ;
% S = [the, turtle, beats, achilles] ;
% S = [the, turtle, beats, the, lazy, turtle] ;
% S = [the, turtle, beats, the, rapid, turtle] ;
% S = [the, turtle, beats, the, turtle].

% https://book.simply-logical.space/src/text/3_part_iii/7.2.html

roman(N) -->
  d(N4,4),
  d(N3,3),
  d(N2,2),
  d(N1,1),
  {N is N4*1000+N3*100+N2*10+N1}.

i(1) --> [i].
i(2) --> [x].
i(3) --> [c].
i(4) --> [m].

v(1) --> [v].
v(2) --> [l].
v(3) --> [d].

d(0,_) --> [].
d(1,N) --> i(N).
d(2,N) --> i(N),i(N).
d(3,N) --> i(N),i(N),i(N).
d(4,N) --> i(N),v(N).
%d(4,N) --> i(N),i(N),i(N),i(N).
d(5,N) --> v(N).
d(6,N) --> v(N),i(N).
d(7,N) --> v(N),i(N),i(N).
d(8,N) --> v(N),i(N),i(N),i(N).
d(9,N) --> i(N),{N1 is N+1},i(N1).

% ?- phrase(roman(2023), N).
% N = [m, m, x, x, i, i, i] .

% ?- phrase(roman(1999), N).
% N = [m, c, m, x, c, i, x] .