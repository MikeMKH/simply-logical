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

% https://book.simply-logical.space/src/text/3_part_iii/7.3.html#ex-7-4

:-op(600,xfy,'=>').
sentence(C)                      --> determiner(N,M1,M2,C),
                                     noun(N,M1),
                                     verb_phrase(N,M2).
sentence([(L:-true)])            --> proper_noun(N,X),
                                     verb_phrase(N,X=>L).
verb_phrase(s,M)                 --> [is],property(s,M).
verb_phrase(p,M)                 --> [are],property(p,M).
property(s,M)                    --> [a],noun(s,M).
property(p,M)                    --> noun(p,M).
property(_N,X=>mortal(X))        --> [mortal].
determiner(s,X=>B,X=>H,[(H:-B)]) --> [every].
determiner(p,sk=>H1,sk=>H2,[(H1:-true),(H2:-true)]) --> [some].
proper_noun(s,socrates)          --> [socrates].
noun(s,X=>human(X))              --> [human].
noun(p,X=>human(X))              --> [humans].
noun(s,X=>living_being(X))       --> [living],[being].
noun(p,X=>living_being(X))       --> [living],[beings].

question(Q)          --> [who],[is],property(s,_X=>Q).
question(Q)          --> [is],proper_noun(N,X),
                         property(N,X=>Q).
question((Q1,Q2))    --> [are],[some],noun(p,sk=>Q1),
                         property(p,sk=>Q2).

% ?- phrase(question(Q), R).
% Q = human(_),
% R = [who, is, a, human] ;
% Q = living_being(_),
% R = [who, is, a, living, being] ;
% Q = mortal(_),
% R = [who, is, mortal] ;
% Q = human(socrates),
% R = [is, socrates, a, human] ;
% Q = living_being(socrates),
% R = [is, socrates, a, living, being] ;
% Q = mortal(socrates),
% R = [is, socrates, mortal] ;
% Q = (human(sk), human(sk)),
% R = [are, some, humans, humans] ;
% Q = (human(sk), living_being(sk)),
% R = [are, some, humans, living, beings] ;
% Q = (human(sk), mortal(sk)),
% R = [are, some, humans, mortal] ;
% Q = (living_being(sk), human(sk)),
% R = [are, some, living, beings, humans] ;
% Q = (living_being(sk), living_being(sk)),
% R = [are, some, living, beings, living, beings] ;
% Q = (living_being(sk), mortal(sk)),
% R = [are, some, living, beings, mortal].

% ?- phrase(question(A), [is, socrates, mortal]).
% A = mortal(socrates).