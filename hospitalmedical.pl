:- dynamic(patient/4).  % Define dynamic predicatefor patient records.

% Define diseases and their symptoms
disease(influenza, [fever, cough, fatigue, bodyacne, headache]).
disease(common_cold, [cough, fatigue, bodyacne, headache]).
disease(gastroenteritis, [vomiting, diarrhea, nausea]).

% Define treatmentsfor diseases
treatment(influenza, 'Rest, stay hydrated, and take pain relievers.').
treatment(influenza, 'Rest, drink plenty of fluids, and take cold medication.').
treatment(gastroenteritis, 'Stay hydrated by drinking pure fluids and avoid dairy products.').

% Predicate to diagnose a patient based on symptoms
diagnose_patient :-
    write('Please provide patient information:'), nl,
    write('Name: '),
    read(Name),
    write('Age: '),
    read(Age),
    write('Gender: '),
    read(Gender),
    write('Symptoms (comma-separated): '),
    read(Symptoms),
    assertz(patient(Name, Age, Gender, Symptoms)),
    diagnose(Name).

% Predicate to diagnose a patient
diagnose(Name) :-
    patient(Name, _, _, Symptoms),
    disease(Disease, DiseaseSymptoms),
    subset(DiseaseSymptoms, Symptoms),
    nl, write('Diagnosis for: '), write(Name), write(':'), nl,
    write('Possible disease: '), write(Disease), nl,
    write('Symptoms: '), write(DiseaseSymptoms), nl,
    write('Treatment recommendation: '), treatment(Disease, Treatment), write(Treatment), nl.

% Predicate to checkif a list is a subset of another list
subset([], _).
subset([H | T], L) :-
    member(H, L),
    subset(T, L).

% Entry point
start :-
    write('---Welcome to the Hospital and Medical Facilities Expert System---'), nl,
    repeat,
    write('What would you like to do?'), nl,
    write('1. Diagnose a patient'), nl,
    write('2. Exit'), nl,
    read_choice.

% Read user choice
read_choice :-
    write('Enter your choice (1-2): '),
    read(Choice),
    execute_choice(Choice).

% Execute user choice
execute_choice(1) :-
    diagnose_patient,
    start.
execute_choice(2) :-
    write('Exiting...'), nl.
execute_choice(_) :-
    write('Invalid choice. Please try again.'), nl,
    fail. % Repeat the menu prompt

% Entry point
:- start.
