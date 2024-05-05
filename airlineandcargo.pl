% Define facts about airline schedules
flight(chicago, new_york, 6:00, 7:00).
flight(chicago, los_angeles, 8:00, 11:00).
flight(new_york, london, 12:00, 18:00).
flight(new_york, los_angeles, 11:00, 14:00).
flight(london, singapore, 20:00, 8:00).

% Define facts about cargo schedules
cargo_schedule(chicago, new_york, monday, 50).
cargo_schedule(chicago, new_york, tuesday, 75).
cargo_schedule(chicago, los_angeles, wednesday, 100).
cargo_schedule(new_york, london, thursday, 40).
cargo_schedule(new_york, los_angeles, friday, 60).
cargo_schedule(london, singapore, saturday, 80).

% Rules to checkif there is a flight available between two cities
flight_available(From, To, DepartureTime, ArrivalTime) :-
    flight(From, To, DepartureTime, ArrivalTime).
% Rules to checkif there is cargo scheduled between two cities on a specific day
cargo_available(From, To, Day, Quantity) :-
    cargo_schedule(From, To, Day, Quantity).
% Expertsystem rule to suggest a flight based on cargo schedule
suggest_flight(From, To, Day, Quantity) :-
    cargo_available(From, To, Day, Quantity),
    flight_available(From, To, _, _),
    format('Flight Available from ~w to ~w on ~w for cargo of quantity ~w. ~n',[From,To,Day,Quantity]).
% Display all flights
display_flights :-
    write('All Available Flights:'), nl,
    flight(From, To, DepartureTime, ArrivalTime),
    write('From: '), write(From), write(' To: '), write(To),
    write(' Departure Time: '), write(DepartureTime),
    write(' Arrival Time: '), write(ArrivalTime), nl,
    fail.
display_flights.
% Avaialble Flights selected Destination
suggest_avl_fligh(Origin , Destination) :-
    flight(Origin,Destination, DepartureTime, ArrivalTime),
    format('Available Flight from ~w to ~w is going to Departure from ~w and will Arrive at ~w .~n',[Origin,Destination,DepartureTime,ArrivalTime]).
% Main menu
menu :-
    write('1. Suggest Flight for Cargo'), nl,
    write('2. Suggest Avaialble Flight'), nl,
    write('3. Display All Flights'), nl,
    write('4. Exit'), nl,
    write('Enter your choice: '),
    read(Choice),
    process_choice(Choice).
% Process users choice
process_choice(1) :-
    write('Enter Origin: '),
    read(Origin),
    write('Enter Destination: '),
    read(Destination),
    write('Enter Day: '),
    read(Day),
    write('Enter Quantity: '),
    read(Quantity),
    suggest_flight(Origin, Destination, Day, Quantity),nl,
    menu.
process_choice(2) :-
    write('Enter Origin: '),
    read(Origin),
    write('Enter Destination: '),
    read(Destination),
    suggest_avl_fligh(Origin,Destination),nl,
    menu.
process_choice(3) :-
    display_flights,
    menu.
process_choice(4) :-
    write('Exiting...').
process_choice(_) :-
    write('Invalid choice. Please try again.'), nl,
    menu.
% Entry point
:- initialization(menu).
