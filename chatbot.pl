% Define greetings
greetings([hi, hello, heyy]).

% Define responses to greetings
response(hi, ['Hi!', 'Hello!', 'Hi, How can I help you']).
response(hello, ['Hi!', 'Hello!', 'Hi, How can I help you']).
response(heyy, ['Hi!', 'Hello!', 'Hi, How can I help you']).

% Define responses totime-related queries
time('what is the time', [TimeString]) :-
    get_time(Time),
    format_time(atom(TimeAtom), '%T', Time),
    string_concat('The time is ', TimeAtom, TimeString).

time('what is the date today', [TimeString]) :-
    get_time(Time),
    format_time(atom(TimeAtom), '%D', Time),
    string_concat('The Date is ', TimeAtom, TimeString).

time('what is the day today', [TimeString]) :-
    get_time(Time),
    format_time(atom(TimeAtom), '%A', Time),
    string_concat('The day is ', TimeAtom, TimeString).

time('what is the month today', [TimeString]) :-
    get_time(Time),
    format_time(atom(TimeAtom), '%B', Time),
    string_concat('The month is ', TimeAtom, TimeString).

time('what is the year today', [TimeString]) :-
    get_time(Time),
    format_time(atom(TimeAtom), '%Y', Time),
    string_concat('The year is ', TimeAtom, TimeString).

% Define response for unknown queries
unknown(_, ['I am sorry, I am not able to understand what you are saying!']).

% Convert atom to lowercase
atom_lowercase(Atom, LowercaseAtom) :-
    atom_chars(Atom, CharList),
    maplist(lowercase_char, CharList, LowercaseCharList),
    atom_chars(LowercaseAtom, LowercaseCharList).

lowercase_char(Char, LowercaseChar) :-
    char_code(Char, Code),
    (Code >= 65, Code =< 90 -> NewCode is Code + 32 ; NewCode is Code),
    char_code(LowercaseChar, NewCode).

% Main chat function
chat :-
    write("Chatbot: Hello!, how can I help you."), nl,
    repeat,
    write("You: "),
    read_line_to_codes(user_input,Input),
    atom_codes(Query,Input),
    atom_lowercase(Query, LowerQuery), % Convert query to lowercase
    (
        LowerQuery = bye ->  write('Chatbot: Goodbye!'), nl, !; % If query is 'bye', end conversation
        response(LowerQuery, Response) ->  random_member(Reply, Response), write('chatbot: '), write(Reply), nl, fail; % If query matches a greeting, respond with a random greeting
        time(LowerQuery, Response), random_member(Reply, Response), write('chatbot: '), write(Reply), nl, fail  ; % If query is about time, respond with current time
        unknown(LowerQuery, Response)  ->  write('chatbot: I am sorry, I am not able to understand what you are saying!'), nl, fail % If query is unknown, respond with a default message
    ),
    write("Chatbot: Is there anything else I can help you with? (yes/no)"), nl,
    read_line_to_codes(user_input,Response),
    atom_codes(ResponseAtom,Response),
    atom_lowercase(ResponseAtom, LowerResponse),
    (LowerResponse = yes ; LowerResponse = y), !, fail.

% Test cases
:- chat. % Start the chatbot
