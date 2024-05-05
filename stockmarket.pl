% Facts defining some stock attributes and market conditions
stock(appl, price(150), trend(up)).
stock(goog, price(2000), trend(up)).
stock(msft, price(250), trend(down)).
stock(fb, price(300), trend(up)).

% Rules to determine whether to buy, sell, or hold a stock
action(X, Quantity, buy) :-
    stock(X, price(Price), trend(up)),
    Price < 1000,
    TotalPrice is Quantity * Price,
    TotalPrice < 10000. % Buyif the total price is below $ 10000 and the trend is up

action(X, _, buy) :-
    stock(X, price(Price), trend(up)),
    Price < 1000. % If quantity isnot specified, defaultto 1

action(X, Quantity, sell) :-
    stock(X, price(Price), trend(down)),
    Price > 200,
    Quantity > 0. % Sellif the price is above $ 200, the trend is down, and quantity is specified

action(X, _, sell) :-
    stock(X, price(Price), trend(down)),
    Price > 200. % If quantity is not specified, defaultto 1

action(X, _, hold) :-
    stock(X, price(Price), trend(Trend)),
    (Trend = up, Price >= 1000);
    (Trend = down, Price =< 200). % Holdif the price is $ 1000 or above and the trend is up, or ifthe price is $ 200 or below and the trend is down

% Predicate to display the menu and get user input
menu :-
    write('===== Stock Trading Expert System ====='), nl,
    write('1. Get recommendation'), nl,
    write('2. Exit'), nl,
    write('Enter your choice: '),
    read(Choice),
    process_choice(Choice).

% Predicate to process user choice
process_choice(1) :-
    ask_user,
    menu.

process_choice(2) :-
    write('Exiting...'), nl.

process_choice(_) :-
    write('Invalid choice. Please enter 1 or 2.'), nl,
    menu.

% Predicate to interact with the user and get input
ask_user :-
    write('Enter stock symbol: '),
    read(Symbol),
    write('Enter quantity: '),
    read(Quantity),
    action(Symbol, Quantity, Action),
    format('Recommendation: ~w ~w shares of ~w .~n', [Action, Quantity,Symbol]).

% Example usage:
% ?- menu.
:-menu.