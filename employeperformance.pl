:-dynamic(employee_performance/5).
:-dynamic(performance/6).

% Define rules to evaluate employee performance based on metrics
performance(Name, QualityOfWork, Punctuality, Teamwork, Communication, OverallPerformance) :-
    assertz(employee_performance(Name, QualityOfWork, Punctuality, Teamwork, Communication)),
    format('Employee name:~w , QualityOfWork :~w , Punctuality:~w , Teamwork:~w , Communication:~w . ~n',[Name, QualityOfWork, Punctuality, Teamwork, Communication]),
    OverallPerformance is (QualityOfWork + Punctuality + Teamwork + Communication) / 4.

% Define rules to assess employees overall performance
evaluate_performance(Performance) :-
    write('Overall performance is: '), write(Performance),
    nl,
    evaluate_performance_level(Performance).

evaluate_performance_level(Performance) :-
    Performance >= 4,
    write('Performance Level: Excellent').
evaluate_performance_level(Performance) :-
    Performance >= 3,
    Performance < 4,
    write('Performance Level: Good').
evaluate_performance_level(Performance) :-
    Performance >= 2,
    Performance < 3,
    write('Performance Level: Satisfactory').
evaluate_performance_level(Performance) :-
    Performance < 2,
    write('Performance Level: Needs Improvement').

% Predicate to take inputfor employees performance metrics
evaluate_employee_performance(Name) :-
    write('Enter Quality of Work (1-5) for '), write(Name), write(': '),
    read(QualityOfWork),
    write('Enter Punctuality (1-5) for '), write(Name), write(': '),
    read(Punctuality),
    write('Enter Teamwork (1-5) for '), write(Name), write(': '),
    read(Teamwork),
    write('Enter Communication (1-5) for '), write(Name), write(': '),
    read(Communication),
    performance(Name, QualityOfWork, Punctuality, Teamwork, Communication, OverallPerformance),
    evaluate_performance(OverallPerformance).

% Predicate to display performance of a specific employee
display_employee_performance(Name) :-
    performance(Name, QualityOfWork, Punctuality, Teamwork, Communication, OverallPerformance),
    write('Performance of '), write(Name), write(':'),
    nl,
    write('Quality of Work: '), write(QualityOfWork),
    nl,
    write('Punctuality: '), write(Punctuality),
    nl,
    write('Teamwork: '), write(Teamwork),
    nl,
    write('Communication: '), write(Communication),
    nl,
    evaluate_performance(OverallPerformance).

% Predicate to display performance of all employees
display_all_employees_performance :-
    employee_performance(Name, _, _, _, _),
    display_employee_performance(Name),
    nl,
    fail. % Fail to backtrack to stop iteration
display_all_employees_performance.

% Entry point
start_evaluation :-
    write('Welcome to the Employee Performance Evaluation System.'),
    nl,
    write('1. Evaluate Employee Performance'),
    nl,
    write('2. Display Performance of a Specific Employee'),
    nl,
    write('3. Display Performance of All Employees'),
    nl,
    read(Choice),
    handle_choice(Choice).

handle_choice(1) :-
    write('Enter the name of the employee: '),
    read(Name),
    evaluate_employee_performance(Name).

handle_choice(2) :-
    write('Enter the name of the employee: '),
    read(Name),
    display_employee_performance(Name).

handle_choice(3) :-
    display_all_employees_performance.

:-start_evaluation.