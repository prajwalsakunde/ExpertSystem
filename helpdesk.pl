:- discontiguous problem/1.
:- discontiguous solution/1.

% Define the predicatesfor different kinds of mobile issues and their solutions

% Issue: Phone wont turn on
problem(phone_wont_turn_on).
solution(phone_wont_turn_on) :-
    write('Solution: Check if the battery is charged. If not, charge the phone.'),
    nl,
    write('If the battery is charged but the phone still won\'t turn on, try restarting it.'),
    nl.

% Issue: Screen is cracked
problem(screen_cracked).
solution(screen_cracked) :-
    write('Solution: If the screen is cracked, you may need to replace it.'),
    nl,
    write('You can contact your phone manufacturer for repair options.'),
    nl.

% Issue: Poor battery life
problem(poor_battery_life).
solution(poor_battery_life) :-
    write('Solution: Try closing background apps and reducing screen brightness to save battery life.'),
    nl,
    write('If the problem persists, you may need to replace the battery or get it checked by a professional.'),
    nl.

% Issue: Mobile network connection issues
problem(network_connection_issues).
solution(network_connection_issues) :-
    write('Solution: Check if your mobile data or Wi-Fi is turned on and if you have a stable connection.'),
    nl,
    write('If the issue persists, try restarting your phone or contacting your service provider for assistance.'),
    nl.

% Issue: Mobile overheating
problem(overheating).
solution(overheating) :-
    write('Solution: Make sure your phone is not exposed to direct sunlight or high temperatures for extended periods.'),
    nl,
    write('Close any unused apps and avoid running heavy applications for too long.'),
    nl,
    write('If the problem continues, you may need to get your phone checked by a technician.'),
    nl.

% Define a predicate to ask for help and provide solutions
ask_for_help :-
    write('Welcome to the mobile help desk system.'),
    nl,
    write('What kind of help do you need?'),
    nl,
    write('1. Phone won\'t turn on'),
    nl,
    write('2. Screen is cracked'),
    nl,
    write('3. Poor battery life'),
    nl,
    write('4. Mobile network connection issues'),
    nl,
    write('5. Mobile overheating'),
    nl,
    write('6.Exit'),
    nl,
    read(Choice), % Singleton variable
    handle_problem(Choice).

handle_problem(1) :-
    problem(phone_wont_turn_on),
    solution(phone_wont_turn_on),
    !,
    nl,
    write('Do you need any further assistance? (YES:1/NO:0)'),
    nl,
    read(Response),
    (Response = 1 -> ask_for_help(); true).
    
handle_problem(2) :-
    problem(screen_cracked),
    solution(screen_cracked),
    !,
    nl,
    write('Do you need any further assistance? (YES:1/NO:0)'),
    nl,
    read(Response),
    (Response = 1 -> ask_for_help(); true).

handle_problem(3) :-
    problem(poor_battery_life),
    solution(poor_battery_life),
    !,
    nl,
    write('Do you need any further assistance? (YES:1/NO:0)'),
    nl,
    read(Response),
    (Response = 1 -> ask_for_help(); true).

handle_problem(4) :-
    problem(network_connection_issues),
    solution(network_connection_issues),
    !,
    nl,
    write('Do you need any further assistance? (YES:1/NO:0)'),
    nl,
    read(Response),
    (Response = 1 -> ask_for_help(); true).

handle_problem(5) :-
    problem(overheating),
    solution(overheating),
    !,
    nl,
    write('Do you need any further assistance? (YES:1/NO:0)'),
    nl,
    read(Response),
    (Response = 1 -> ask_for_help(); true).
handle_problem(6):-
    write('Ending...'),nl.

handle_problem(_) :-
    nl,
    write('Sorry, I couldn\'t understand your request.'),
    nl,
    ask_for_help().

start :-
    ask_for_help.

:-start.