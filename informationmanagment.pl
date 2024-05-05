% Facts to store information
:- dynamic(product/3).

% Predicate to start the information managementsystem
start :-
    write('Welcome to the Information Management System!'), nl,
    write('What would you like to do?'), nl,
    menu.

% Display menu options
menu :-
    write('1. Add a product'), nl,
    write('2. Display all product'), nl,
    write('3. Display a perticular product'), nl,
    write('4. Update a perticular product '), nl,
    write('5. Delete a product'), nl,
    write('6. Clear all information'), nl,
    write('7. Exit'), nl,
    read_choice.

% Read user choice
read_choice :-
    write('Enter your choice (1-7): '),
    read(Choice),
    execute_choice(Choice).

% Execute user choice
execute_choice(1) :-
    add_product_input,
    menu.
execute_choice(2) :-
    display_all_product,
    menu.
execute_choice(3) :-
    write('Enter the name of the product: '),
    read(Name),
    display_product(Name),
    menu.
execute_choice(4) :-
    write('Enter the name of the product to update: '),
    read(Name),
    write('Enter the price: '),
    read(NewPrice),
    write('Enter the discription: '),
    read(NewDiscription),
    update_product(Name, NewPrice, NewDiscription),
    menu.
execute_choice(5) :-
    write('Enter the name of the product to delete: '),
    read(Name),
    delete_product(Name),
    menu.
execute_choice(6) :-
    clear_all,
    menu.
execute_choice(7) :-
    write('Exiting...'), nl.
execute_choice(_) :-
    write('Invalid choice. Please try again.'), nl,
    menu.

% 1Adding information about a product based on user input
add_product_input :-
    write('Enter the name of the product: '),
    read(Name),
    write('Enter the price of the product: '),
    read(Price),
    write('Enter the discription of the product: '),
    read(Discription),
    add_product(Name, Price, Discription),
    write('Product added successfully.'),nl.

% Adding information about a product
add_product(Name, Price, Discription) :-
    assertz(product(Name, Price, Discription)),
    write('Product added successfully.').

% Displaying information about all products
display_all_product :-
    product(Name,Price, Discription),
    format('Name: ~w, Price: ~w, Discription: ~w~n', [Name, Price, Discription]),
    fail,nl. % to force backtracking and find all solutions

% Displaying information about a specific product
display_product(Name) :-
    product(Name, Price, Discription),
    format('Name: ~w, Price: ~w, Discription: ~w~n', [Name, Price, Discription]).

% Updating information about a person
update_product(Name, NewPrice, NewDiscription) :-
    retract(product(Name, _, _)),
    assertz(product(Name, NewPrice, NewDiscription)),
    write('Information updated successfully.'),nl.

% Deleting information about a person
delete_product(Name) :-
    retract(product(Name, _, _)),
    write('Product deleted successfully.'),nl.

% Clearing all information
clear_all :-
    retractall(product(_, _, _)),
    write('All information cleared successfully.'),nl.



% Entry point
:- start.
