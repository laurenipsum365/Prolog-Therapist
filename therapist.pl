
% ----------------------------------------- %
% ---------- Relevant Relations ----------- %
% ----------------------------------------- %

% Procedures to define relevant relations
defineFamily :-
    assert(family(granddad)),
    assert(family(granddads)),
    assert(family(grandfather)),
    assert(family(grandfathers)),
    assert(family(dad)),
    assert(family(dads)),
    assert(family(father)),
    assert(family(fathers)),
    assert(family(brother)),
    assert(family(brothers)),
    assert(family(sister)),
    assert(family(sisters)),
    assert(family(cousin)),
    assert(family(cousins)),
    assert(family(nephew)),
    assert(family(nephews)),
    assert(family(mother)),
    assert(family(mothers)),
    assert(family(mom)),
    assert(family(moms)),
    assert(family(grandmother)),
    assert(family(grandmothers)),
    assert(family(grandmom)).
	
defineFeelings :-
    assert(feelings(sad)),
    assert(feelings(upset)),
    assert(feelings(angry)),
    assert(feelings(mad)),
    assert(feelings(happy)),
    assert(feelings(scared)),
    assert(feelings(anxious)),
    assert(feelings(guilt)),
    assert(feelings(guilty)),
    assert(feelings(fear)),
    assert(feelings(good)),
    assert(feelings(bad)),
    assert(feelings(stress)),
    assert(feelings(stressed)),
    assert(feelings(alright)),
    assert(feelings(joy)).

defineWork :-
    assert(work(working)),
    assert(work(programming)),
    assert(work(program)),
    assert(work(hammering)),
    assert(work(building)),
    assert(work(job)),
    assert(work(work)).
    
% Procedures to identify relevant relations 
isFamily(Y) :-
    family(Y).

isAFeeling(F) :-
    feelings(F).

isWork(W) :-
    work(W).

% ----------------------------------------- %
% ------------ Therapy Session ------------ %
% ----------------------------------------- %
removehead([_|Tail], Tail).
remove_char(S,C,X) :- atom_concat(L,R,S), atom_concat(C,W,R), atom_concat(L,W,X).

startTherapy :- 
        write("How are you feeling today?"),
        continueSession().

continueSession() :-
        nl, read_line_to_codes(user_input,Cs), atom_codes(A, Cs), atomic_list_concat(UserResponse, ' ', A),
        length(UserResponse, Size),
        iterateList(UserResponse, Size).

iterateList(List, Size) :-
        (Size > 0 ->
                     nth0(0,List,H),
                     (Size = 1 -> remove_char(H,.,H1),
                                  % conditional 2 - check Head for relevance with periods on end 
                                  (isAFeeling(H1) -> respondToFeel(H1), break;
                                  isFamily(H1)    -> respondToFam(H1),  break; 
                                  isWork(H1)      -> respondToWork(),  break;
                                                     write(""));
                                  write("")), 

                     % conditional 3 - check Head for relevance without periods on end
                     (isAFeeling(H) -> respondToFeel(H), break;
                     isFamily(H)    -> respondToFam(H),  break; 
                     isWork(H)      -> respondToWork(),  break;
                                       write("")),
          
                  /***
                   * If head of the list fails all checks for relevant words
                   * from above, then keep popping off the top of the list
                   * and check the next element for relevance
                   ***/
                   removehead(List, New), 
                   length(New, S),
                   iterateList(New, S); % end of if statement for size check
		   write("")), 

        nl, nl, write("I see. Please continue."),  
        continueSession.

respondToFeel(Feel) :-
    nl, nl, 
    write("Why do you feel "),
    write(Feel), write("?"), 
    continueSession.

respondToFam(Fam) :-
    nl, nl, 
    write("Tell me more about your family and your "),
    write(Fam), write(", in particular"), 
    continueSession.

respondToWork() :-
    nl, nl, 
    write("Tell me more about your work"),
    continueSession.

?- defineFamily.
?- defineFeelings.
?- defineWork.
?- startTherapy.
