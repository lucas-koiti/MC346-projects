%
%  Authors:
%        Lucas Koiti G Tamanaha - RA 182579
%        Esdras Rodrigues do Carmo - RA XXXXXX

:- use_module(library(clpq)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Recebe uma lista de figuras no plano cartesiano %
% Imprimi a quantidade de interseccoes entre elas %
% e os pares                                      %
% swipl -q -f pro01.pl -t topo < arqtest.in       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
topo():-
    read(Input),
    qtdintersec(Input,Output, L),
    %write('QUANTIDADE: '),nl,
    write_ln(Output),
    %write('PARES: '),nl,
    printlist(L).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% exibir os pares, um por linha
printlist([]).
printlist([X|List]) :-
    write(X),nl,
    printlist(List).

% quantidade de interseccoes dada uma lista de figuras
qtdintersec([], 0, []).
qtdintersec([X|XS],N,P):- qtd(X, XS, L, Q), qtdintersec(XS, R, Z), N is L+R, append(Q,Z,P), !.

qtd(_,[],0,[]).
qtd(X,[C|CS],Q,L) :- qtd(X,CS,QQ,LL), intersec(X,C,Dupla), Q is QQ+1, L = [Dupla|LL].
qtd(X,[_|CS],Q,L) :- qtd(X,CS,Q,L).

intersec(quad(A,X1,Y1,L1),quad(B,X2,Y2,L2), Dupla) :-
    quadsolver(X1,Y1,X2,Y2,L1,L2), Dupla = (A,B).

intersec(circ(N,X1,Y1,R1), circ(M,X2,Y2,R2), Dupla) :-
    circsolver(X1,Y1,X2,Y2,R1,R2), Dupla = (N,M).

intersec(circ(A,X1,Y1,R1), quad(B,X2,Y2,R2), Dupla) :-
    cqsolver(X1,Y1,R1,X2,Y2,R2), Dupla = (A,B).

intersec(quad(A,X1,Y1,R1), circ(B,X2,Y2,R2), Dupla) :-
    cqsolver(X2,Y2,R2,X1,Y1,R1), Dupla = (A,B).

%checa se dois quadrados se intersectam
quadsolver(X1,Y1,X2,Y2,L1,L2) :-
    AL1 is round(L1/2),
    AX1 is (X1 - AL1), AX2 is (X1 + AL1),
    AY1 is (Y1 - AL1), AY2 is (Y1 + AL1),
    BL2 is round(L2/2),
    BX1 is (X2 - BL2), BX2 is (X2 + BL2),
    BY1 is (Y2 - BL2), BY2 is (Y2 + BL2),
    ((BX1 =< AX2, BX1 >= AX1);(BX2 =< AX2,BX2 >= AX1)),
    ((BY1 =< AY2, BY1 >= AY1);(BY2 =< AY2, BY2 >= AY1)).

%checa se dois circulos se intersectam
circsolver(A,B,C,D,R1,R2) :-
    X is float(C-A), Y is float(D-B),
    Aux is float((X*X)+(Y*Y)),
    Dist is sqrt(Aux),
    RR0 is float(R1-R2),
    RR1 is float(R1+R2),
    (Dist = RR1; Dist = RR0;
    Dist < RR1; Dist < RR0),
    !.

% checa intersecao de circulo com quadrado
cqsolver(X1,Y1,R,X2,Y2,L):-
    AL1 is round(L/2),
    AX1 is (X2 - AL1), AX2 is (X2 + AL1),
    AY1 is (Y2 - AL1), AY2 is (Y2 + AL1),
    CX1 is (X1-R), CX2 is (X1+R),
    CY1 is (Y1-R), CY2 is (Y1+R),
    ((CX1 =< AX2, CX1 >= AX1); (CX2 =< AX2, CX2 >= AX1); (X1 =< AX2, X1 >= AX1)),
    ((Y1 =< AY2, Y1 >= AY1); (CY1 =< AY2, CY1 >= AY1); (CY2 =< AY2, CY2 >= AY1)).
