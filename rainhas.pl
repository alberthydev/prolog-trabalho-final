% O tabuleiro é uma lista de posições
% Exemplo: [1, 5, 8, ...] onde o índice é a coluna e o valor é a linha.

resolver(Rainhas) :-
    Rainhas = [_,_,_,_,_,_,_,_],
    template(Rainhas),
    validar(Rainhas).

% Garante que cada rainha esteja em uma linha de 1 a 8
template([]).
template([H|T]) :-
    member(H, [1,2,3,4,5,6,7,8]),
    template(T).

% Regra de validação: verifica se as rainhas não se atacam[cite: 1]
validar([]).
validar([H|T]) :-
    not_ataca(H, T, 1),
    validar(T).

not_ataca(_, [], _).
not_ataca(R1, [R2|Resto], Distancia) :-
    R1 \= R2,
    abs(R1 - R2) \= Distancia,
    ProxDist is Distancia + 1,
    not_ataca(R1, Resto, ProxDist).
