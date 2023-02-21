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