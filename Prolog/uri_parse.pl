%uri(S, UI, H, Port, Path, Q, F).
%inputTxt(T, Rest, Result) :- string_chars(T, L), path(L, Rest, Result).

uri_parse(L, uri(S, UI, H, Port, Path, Q, F)) :-
						string_chars(L, URI),
						scheme(URI, URIexcS, S),
						member(S, ['mailto', 'tel', 'fax', 'news', 'zos']), !,
						scheme-syntax(URIexcS, S, UI, H, Port, Path, Q, F), !.

uri_parse(L, uri(S, UI, H, Port, Path, Q, F)) :-
						string_chars(L, URI),
						scheme(URI, URIexcS, S),
						authority(URIexcS, URIexcSA, UI, H, Port),
						pqf(URIexcSA, false, Path, Q, F), !.

scheme-syntax(X, 'mailto', UI, H, 80, [], [], []) :-
						userinfo(X, false, ['@'|RestUI], UI),
						host(RestUI, false, [], H).

scheme-syntax(X, 'mailto', UI, [], 80, [], [], []) :-
						userinfo(X, true, [], UI).
scheme-syntax(X, 'tel', UI, [], 80, [], [], []) :- userinfo(X, true, [], UI).
scheme-syntax(X, 'fax', UI, [], 80, [], [], []) :- userinfo(X, true, [], UI).
scheme-syntax(X, 'news', [], H, 80, [], [], []) :- host(X, true, [], H).
scheme-syntax(X, 'zos', UI, H, Port, Path, Q, F) :-
						authority(X, URIexcA, UI, H, Port),
						pqf(URIexcA, true, Path, Q, F), !.

scheme(X, Rest, Result) :- identificatore(X, [':'|Rest], Result).

authority(['/','/'|Xs], Rest, UI, H, P) :-
						userinfo(Xs, true, ['@'|RestUI], UI),
						host(RestUI, false, RestH, H),
						port(RestH, Rest, P), !.
authority(['/','/'|Xs], Rest, UI, H, 80) :-
						userinfo(Xs, true, ['@'|RestUI], UI),
						host(RestUI, false, Rest, H).
authority(['/','/'|Xs], Rest, [], H, P) :-
						host(Xs, false, RestH, H),
						port(RestH, Rest, P), !.
authority(Rest, Rest, [], [], 80).

userinfo(X, _, Rest, Result) :- identificatore(X, Rest, Result), !.
userinfo(Rest, true, Rest, []).

pqf([], _, [],[],[]).
pqf(['/'|Xs], Zos, P, Q, F) :-
						path(Xs, Zos, RestP, P), !,
						query(RestP, RestQ, Q), !,
						fragment(RestQ, [], F).

path(X, false, Rest, Result) :-
						identificatore(X, RestI, I),
						identificatori(RestI, Rest, Is), !,
						atomic_concat(I, Is, Result).

path(X, true, Rest, Result) :-
						id44(X, ['('|Rest44], Res44),
						id8(Rest44, [')'|Rest], Res8), !,
						atomic_concat('(', Res8, RRes8),
						atomic_concat(RRes8, ')', RRes8R),
						atomic_concat(Res44, RRes8R, Result).
path(X, true, Rest, Result) :- id44(X, Rest, Result), !.
path(X, false, Rest, Result) :- identificatore(X, Rest, Result), !.
path(Rest, false, Rest, []).

identificatori(['/'|Xs], Rest, Result) :-
						identificatore(Xs, RestI, I),
						identificatori(RestI, Rest, Is), !,
						atomic_concat('/', I, SlashI),
						atomic_concat(SlashI, Is, Result).
identificatori(['/'|Xs], Rest, Result) :- 
						identificatore(Xs, Rest, X),
						atomic_concat('/', X, Result), !.

query(['?'|Xs], Rest, Result) :-
						caratteri(Xs, Rest, Result, ['#']), !.
query(Rest, Rest, []).

fragment(['#'|Xs], Rest, Result) :-
						caratteri(Xs, Rest, Result, []), !.
fragment(Rest, Rest, []).

host(H, _, Rest, Result) :- countGroup(H, Rest, Result, 4).
host(H, _, Rest, Result) :-
						identificatore_host(H, RestI, I),
						identificatori_host(RestI, Rest, Is), !,
						atomic_concat(I, Is, Result).
host(X, _, Rest, Result) :- identificatore_host(X, Rest, Result), !.
host(Rest, true, Rest, []).

ip(X, Rest, Result) :- countGroup(X, Rest, Result, 4).

countGroup(['.'|X], Rest, Result, Ngr) :-
						digits(X, RestD, D),
						atom_number(D, Num),
						between(0, 255, Num), !,
						countGroup(RestD, Rest, Ds, N),
						atomic_concat('.', D, DotD),
						atomic_concat(DotD, Ds, Result),
						Ngr is N + 1,
						Ngr > 0, !.

countGroup(X, Rest, Result, Ngr) :-
						digits(X, RestD, D),
						atom_number(D, Num),
						between(0, 255, Num), !,
						countGroup(RestD, Rest, Ds, N),
						Ngr is N + 1,
						atomic_concat(D, Ds, Result),
						Ngr > 0, !.

countGroup(X, Rest, Result, 0) :- 
						digits(X, Rest, D),
						atom_number(D, Result),
						between(0, 255, Result), !.

identificatori_host(['.'|Xs], Rest, Result) :-
						identificatore_host(Xs, RestI, I),
						identificatori_host(RestI, Rest, Is), !,
						atomic_concat('.', I, DotI),
						atomic_concat(DotI, Is, Result).
identificatori_host(['.'|Xs], Rest, Result) :- 
						identificatore_host(Xs, Rest, I),
						atomic_concat('.', I, Result), !.

identificatore(X, Rest, Result) :-
						caratteri(X, Rest, Result, ['/','?','#','@',':']).

identificatore_host(X, Rest, Result) :-
						caratteri(X, Rest, Result, ['.','/','?','#','@',':']).

id44tail(['.'|Xs], Rest, Result) :-
						id44tail(Xs, Rest, Res),
						atomic_concat('.', Res, Result).
id44tail(X, Rest, Result) :-
						caratteriAN(X, RestCs, Cs),
						id44tail(RestCs, Rest, Res), !,
						atomic_concat(Cs, Res, Result).
id44tail(X, Rest, Result) :- caratteriAN(X, Rest, Result), !.

id44([X|Xs], Rest, Result) :-
						carattereAlfabetico(X), !,
						id44tail([X|Xs], Rest, Result), !,
						string_length(Result, Ln),
						between(1, 44, Ln).

id8(X, Rest, Result) :- caratteriAN(X, Rest, Result),
						string_length(Result, Ln),
						between(1, 8, Ln).

port([':'|Xs], Rest, Result) :-
						digits(Xs, Rest, Ds),
						atom_number(Ds, Result).
port(Rest, Rest, 80).

caratteriAN([C|Cs], Rest, Result):-
						carattereAN(C),
						caratteriAN(Cs, Rest, R), !,
						atomic_concat(C, R, Result).
caratteriAN([C|Rest], Rest, C) :- carattereAN(C), !.

carattereAN(C) :- digit(C), !.
carattereAN(C) :- carattereAlfabetico(C), !.

caratteri([C|Cs], Rest, Result, Filtri) :-
						non_member(C,Filtri),
						carattere(C),
						caratteri(Cs, Rest, R, Filtri), !,
						atomic_concat(C, R, Result).
caratteri([C|Rest], Rest, C, Filtri) :- 
						non_member(C,Filtri),
						carattere(C), !.

carattere(C) :- reserved(C), !.
carattere(C) :- unreserved(C), !.

%gen-delims
reserved(C) :- member(C, [':','/','?','#','[',']','@']).
%sub-delims
reserved(C) :- member(C, ['!','$','&','\',','(',')','*','+',',',';','=']).

unreserved(C) :- digit(C), !.
unreserved(C) :- carattereAlfabetico(C), !.
unreserved(C) :- member(C, ['-','.','_','~']), !.

carattereAlfabetico(C) :- lower_az(C), !.
carattereAlfabetico(C) :- upper_az(C), !.

lower_az(C) :-
						char_code(C, N),
						N >= 97, N =< 122, !.

upper_az(C) :-
						char_code(C, N),
						N >= 65,
						N =< 90, !.

digits([D|Ds], Rest, Result) :-
						digit(D),
						digits(Ds, Rest, R), !,
						atomic_concat(D, R, Result).
digits([D|Rest], Rest, D) :- digit(D), !.

digit(C) :-
						atom_number(C, D),
						between(0, 9, D), !.

non_member(X, [X|_]) :- !, fail.
non_member(X, [_|Xs]) :- !, non_member(X, Xs).
non_member(_, []).

uri_display(uri(S, UI, H, Port, Path, Q, F)) :-
						multi_write(['Schema: ', S]),
						multi_write(['UserInfo: ', UI]),
						multi_write(['Host: ', H]),
						multi_write(['Port: ', Port]),
						multi_write(['Path: ', Path]),
						multi_write(['Query: ', Q]),
						multi_write(['Fragment: ', F]).

uri_display(uri(S, UI, H, Port, Path, Q, F), Stream) :-
						current_output(O),
						open(Stream, append, StreamId),
						set_output(StreamId),
						writeln('URI display:'),
						multi_write(['\tSchema: ', S]),
						multi_write(['\tUserInfo: ', UI]),
						multi_write(['\tHost: ', H]),
						multi_write(['\tPort: ', Port]),
						multi_write(['\tPath: ', Path]),
						multi_write(['\tQuery: ', Q]),
						multi_write(['\tFragment: ', F]),
						set_output(O),
						close(StreamId).

multi_write(Terms) :-
						atomics_to_string(Terms, Res),
						writeln(Res).