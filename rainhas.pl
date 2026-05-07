iniciar :-
    nl, writeln('========================================'),
    writeln('       SIMULADOR DAS 8 RAINHAS          '),
    writeln('========================================'),
    writeln('1. Encontrar solucao automatica (Backtracking)'),
    writeln('2. Modo Desafio (Voce joga)'),
    writeln('3. Sair'),
    writeln('========================================'),
    write('Escolha uma opcao: '), read(Opcao),
    executar(Opcao).

executar(1) :- 
    template(S), 
    solucao(S), 
    exibir_tabuleiro(S), 
    writeln('Deseja buscar outra solucao? (s/n).'),
    read(Resp),
    (Resp == s -> fail ; iniciar).

executar(2) :- 
    writeln('\n--- DESAFIO MANUAL ---'),
    writeln('Tente colocar as rainhas sem que elas se ataquem.'),
    writeln('Dica: Digite 0. a qualquer momento para voltar ao menu.'),
    jogar_manual(1, []),
    iniciar.

executar(3) :- writeln('Encerrando programa...').
executar(_) :- writeln('Opcao invalida!'), iniciar.

solucao([]).
solucao([X/Y|Outros]) :-
    solucao(Outros),
    membro(Y, [1,2,3,4,5,6,7,8]), 
    naoataca(X/Y, Outros).

naoataca(_, []).
naoataca(X/Y, [X1/Y1|Outros]) :-
    Y=\=Y1,
    Y1-Y=\=X1-X,
    Y1-Y=\=X-X1,          
naoataca(X/Y, Outros).


membro(X, [X|_]).
membro(X, [_|Outros]) :- membro(X, Outros).

template([1/Y1, 2/Y2, 3/Y3, 4/Y4, 5/Y5, 6/Y6, 7/Y7, 8/Y8]).

jogar_manual(9, Solucao) :- 
    writeln('\n*** PARABENS! Voce resolveu o quebra-cabeca! ***'),
    exibir_tabuleiro(Solucao),
    writeln('Digite qualquer coisa (ex: ok.) para continuar.'),
    read(_). 

jogar_manual(C, JaPosicionadas) :-
    format('\nColuna ~w [0 para Sair] - Linha (1-8): ', [C]),
    read(L),
    (   L == 0 -> 
        writeln('Retornando ao menu...') 
    ;   member(L, [1,2,3,4,5,6,7,8]) -> 
        (   naoataca(C/L, JaPosicionadas) -> 
            jogar_manual(C + 1, [C/L | JaPosicionadas])
        ;   writeln('-> ATAQUE! Essa posicao e perigosa. Tente outra.'),
            jogar_manual(C, JaPosicionadas)
        )
    ;   writeln('-> Invalido! Digite de 1 a 8 (ou 0) seguido de ponto.'),
        jogar_manual(C, JaPosicionadas)
    ).

exibir_tabuleiro(Solucao) :-
    nl, writeln('   1  2  3  4  5  6  7  8'),
    writeln('  -------------------------'),
    foreach(member(Linha, [1,2,3,4,5,6,7,8]), (
        format('~w |', [Linha]),
        foreach(member(Coluna, [1,2,3,4,5,6,7,8]), (
            (member(Coluna/Linha, Solucao) -> write(' Q ') ; write(' . '))
        )),
        nl
    )),
    writeln('  -------------------------'), nl.
