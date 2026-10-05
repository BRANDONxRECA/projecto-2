% -- INTEGRANTES --
% -Maximiliano Gallardo
% -Brandon Recabarren
% -Pablo Contreras

% -- HECHOS --

% POKEMONES pokemon(X).
pokemon(pikachu).
pokemon(raichu).
pokemon(charmander).
pokemon(charmeleon).
pokemon(charizard).
pokemon(squirtle).
pokemon(wartortle).
pokemon(blastoise).
pokemon(bulbasaur).
pokemon(ivysaur).
pokemon(venusaur).
pokemon(pidgey).
pokemon(pidgeotto).
pokemon(onix).
pokemon(geodude).
pokemon(golem).
pokemon(machop).
pokemon(machoke).
pokemon(gastly).
pokemon(gengar).
pokemon(psyduck).
pokemon(golduck).
pokemon(jigglypuff).
pokemon(meowth).
pokemon(persian).
pokemon(mewtwo).
pokemon(mew).
pokemon(lugia).
pokemon(ho_oh).
pokemon(dragonite).
pokemon(gyarados).
pokemon(snorlax).
pokemon(eevee).
pokemon(vaporeon).
pokemon(jolteon).
pokemon(flareon).

% TIPOS tipo(pokemon(X),Y).
% Volador, Electrico, Psiquico, Acero, Fuego, Agua, Planta,
% Hielo, Lucha, Veneno, Tierra, Normal, Bicho, Roca, Fantasma,
% Dragon, Siniestro, Hada
tipo(pikachu, electrico).
tipo(raichu, electrico).
tipo(charmander, fuego).
tipo(charmeleon, fuego).
tipo(charizard, fuego).
tipo(charizard, volador).
tipo(squirtle, agua).
tipo(wartortle, agua).
tipo(blastoise, agua).
tipo(bulbasaur, planta).
tipo(bulbasaur, veneno).
tipo(ivysaur, planta).
tipo(ivysaur, veneno).
tipo(venusaur, planta).
tipo(venusaur, veneno).
tipo(pidgey, normal).
tipo(pidgey, volador).
tipo(pidgeotto, normal).
tipo(pidgeotto, volador).
tipo(onix, roca).
tipo(onix, tierra).
tipo(geodude, roca).
tipo(geodude, tierra).
tipo(golem, roca).
tipo(golem, tierra).
tipo(machop, lucha).
tipo(machoke, lucha).
tipo(gastly, fantasma).
tipo(gastly, veneno).
tipo(gengar, fantasma).
tipo(gengar, veneno).
tipo(psyduck, agua).
tipo(golduck, agua).
tipo(jigglypuff, normal).
tipo(jigglypuff, hada).
tipo(meowth, normal).
tipo(persian, normal).
tipo(mewtwo, psiquico).
tipo(mew, psiquico).
tipo(lugia, psiquico).
tipo(lugia, volador).
tipo(ho_oh, fuego).
tipo(ho_oh, volador).
tipo(dragonite, dragon).
tipo(dragonite, volador).
tipo(gyarados, agua).
tipo(gyarados, volador).
tipo(snorlax, normal).
tipo(eevee, normal).
tipo(vaporeon, agua).
tipo(jolteon, electrico).
tipo(flareon, fuego).

% ENTRENADORES entrenador(X)
entrenador(ash).
entrenador(red).
entrenador(misty).
entrenador(brock).
entrenador(giovanni).
entrenador(lance).

% POKEMON DE ENTRENADORES tiene(entrenador(X),pokemon(Y)).
tiene(ash, pikachu).
tiene(ash, charizard).
tiene(ash, bulbasaur).
tiene(ash, squirtle).
tiene(ash, snorlax).
tiene(red, charizard).
tiene(red, snorlax).
tiene(red, mewtwo).
tiene(red, gyarados).
tiene(misty, psyduck).
tiene(misty, golduck).
tiene(misty, gyarados).
tiene(brock, onix).
tiene(brock, geodude).
tiene(brock, golem).
tiene(giovanni, persian).
tiene(giovanni, machoke).
tiene(giovanni, gengar).
tiene(lance, dragonite).
tiene(lance, gyarados).
tiene(lance, charizard).

% FORTALEZA fuerte_contra(tipo(X),tipo(Y)).
fuerte_contra(fuego, planta).
fuerte_contra(fuego, hielo).
fuerte_contra(fuego, bicho).
fuerte_contra(fuego, acero).
fuerte_contra(agua, fuego).
fuerte_contra(agua, tierra).
fuerte_contra(agua, roca).
fuerte_contra(electrico, agua).
fuerte_contra(electrico, volador).
fuerte_contra(planta, agua).
fuerte_contra(planta, tierra).
fuerte_contra(planta, roca).
fuerte_contra(hielo, planta).
fuerte_contra(hielo, tierra).
fuerte_contra(hielo, volador).
fuerte_contra(hielo, dragon).
fuerte_contra(lucha, normal).
fuerte_contra(lucha, hielo).
fuerte_contra(lucha, roca).
fuerte_contra(lucha, siniestro).
fuerte_contra(lucha, acero).
fuerte_contra(veneno, planta).
fuerte_contra(veneno, hada).
fuerte_contra(tierra, fuego).
fuerte_contra(tierra, electrico).
fuerte_contra(tierra, veneno).
fuerte_contra(tierra, roca).
fuerte_contra(tierra, acero).
fuerte_contra(volador, planta).
fuerte_contra(volador, lucha).
fuerte_contra(volador, bicho).
fuerte_contra(psiquico, lucha).
fuerte_contra(psiquico, veneno).
fuerte_contra(bicho, planta).
fuerte_contra(bicho, psiquico).
fuerte_contra(bicho, siniestro).
fuerte_contra(roca, fuego).
fuerte_contra(roca, hielo).
fuerte_contra(roca, volador).
fuerte_contra(roca, bicho).
fuerte_contra(fantasma, fantasma).
fuerte_contra(fantasma, psiquico).
fuerte_contra(dragon, dragon).
fuerte_contra(siniestro, fantasma).
fuerte_contra(siniestro, psiquico).
fuerte_contra(acero, hielo).
fuerte_contra(acero, roca).
fuerte_contra(acero, hada).
fuerte_contra(hada, lucha).
fuerte_contra(hada, dragon).
fuerte_contra(hada, siniestro).

% REGLAS

% DEBILIDADES
debil_contra(P, TipoAtaque) :- tipo(P, TipoDefensa), fuerte_contra(TipoAtaque, TipoDefensa).

% DOBLE DEBILIDAD (x4 daño, ambos tipos vulnerables al mismo ataque)
doblemente_debil(P, TipoAtaque) :-
    tipo(P, Tipo1), tipo(P, Tipo2), Tipo1 \= Tipo2,
    fuerte_contra(TipoAtaque, Tipo1), fuerte_contra(TipoAtaque, Tipo2).

% ENTRENADOR VULNERABLE (tiene al menos un pokemon debil contra TipoAtaque)
entrenador_vulnerable(E, TipoAtaque) :- tiene(E, P), debil_contra(P, TipoAtaque).

% VENTAJA ENTRE DOS POKEMON (P1 tiene ventaja de tipo sobre P2)
tiene_ventaja(P1, P2) :- tipo(P1, T1), tipo(P2, T2), fuerte_contra(T1, T2).

% CONSULTAS
% 1.Es pikachu un pokemon?
% ?- pokemon(pikachu). [True]
% 2.Es pikachu de tipo electrico?
% ?- tipo(pikachu, electrico). [True]
% 3.Que tipo(s) es charizard?
% ?- tipo(charizard, Tipo).
% 4.Que pokemon son de tipo fuego?
% ?- tipo(P, fuego).
% 5.Que pares pokemon-tipo existen registrados?
% ?- tipo(P, T).
% 6.Que pokemones tiene ash?
% ?- tiene(ash, P).
% 7.Quien tiene a gyarados?
% ?- tiene(E, gyarados).
% 8.Es electrico fuerte contra agua?
% ?- fuerte_contra(electrico, agua). [True]
% 9.Contra que tipos es fuerte el tipo fuego?
% ?- fuerte_contra(fuego, Tipo).
% 10.Es charizard debil contra agua?
% ?- debil_contra(charizard, agua). [True]
% 11.Contra que tipo de ataque es debil gengar?
% ?- debil_contra(gengar, TipoAtaque).
% 12.Que pokemon son debiles contra tipo hielo?
% ?- debil_contra(P, hielo).
% 13.Es charizard doblemente debil contra roca?
% ?- doblemente_debil(charizard, roca). [True]
% 14.Que pokemon son doblemente debiles y contra que tipo?
% ?- doblemente_debil(P, TipoAtaque).
% 15.Es brock vulnerable a tipo agua?
% ?- entrenador_vulnerable(brock, agua). [True]
% 16.A que tipos de ataque es vulnerable misty?
% ?- entrenador_vulnerable(misty, TipoAtaque).
% 17.Que pokemon de tipo fuego tiene ash?
% ?- tipo(P, fuego), tiene(ash, P).
% 18.Hay algun entrenador registrado que tenga a snorlax?
% ?- entrenador(E), tiene(E, snorlax).
% 19.Es verdad que brock no tiene a pikachu?
% ?- \+ tiene(brock, pikachu). [True]
% 20.Que otro pokemon comparte un tipo con charizard?
% ?- tipo(charizard, T), tipo(P2, T), P2 \= charizard.

% CHATBOT

:- initialization(iniciar_chat).

iniciar_chat :-
    nl, write(" --------------------------------- "), nl,
    write("Bienvenido al chatbot de Pokemon!"), nl,
    write("Preguntame sobre tipos, entrenadores, debilidades y mas"), nl,
    write("Escribe 'salir' para terminar la conversacion"), nl,
    write(" --------------------------------- "), nl,
    bucle_chat.

bucle_chat :-
    nl, write(">Usuario "),
    flush_output(current_output),
    read_line_to_string(user_input, Frase),
    (   Frase == "salir"
    ->  write("Hasta pronto!"), nl
    ;   procesar_consulta(Frase, Respuesta),
        format("Bot > ~w~n", [Respuesta]),
        bucle_chat
    ).

procesar_consulta(Frase, Respuesta) :-
    string_lower(Frase, FraseMinus),
    split_string(FraseMinus, " ", " ,?", TokenStr),
    maplist(atom_string, Tokens, TokenStr),
    interpretar(Tokens, Respuesta).

% REGLA 1 NEGACION: ENTRENADOR NO TIENE UN POKEMON
interpretar(Tokens, Respuesta) :-
    member(no, Tokens),
    member(tiene, Tokens),
    member(Entrenador, Tokens), entrenador(Entrenador),
    member(Pokemon, Tokens), pokemon(Pokemon),
    !,
    (   \+ tiene(Entrenador, Pokemon)
    ->  format(string(Respuesta), "Es verdad, ~w no tiene a ~w", [Entrenador, Pokemon])
    ;   format(string(Respuesta), "Eso es falso, ~w si tiene a ~w", [Entrenador, Pokemon])
    ).

% REGLA 2 BOOLEANO: UN ENTRENADOR TIENE UN POKEMON ESPECIFICO
interpretar(Tokens, Respuesta) :-
    member(tiene, Tokens),
    member(Entrenador, Tokens), entrenador(Entrenador),
    member(Pokemon, Tokens), pokemon(Pokemon),
    !,
    (   tiene(Entrenador, Pokemon)
    ->  format(string(Respuesta), "Si, ~w tiene a ~w", [Entrenador, Pokemon])
    ;   format(string(Respuesta), "No, ~w no tiene a ~w", [Entrenador, Pokemon])
    ).

% REGLA 3 POKEMON DE UN ENTRENADOR FILTRADOS POR TIPO
interpretar(Tokens, Respuesta) :-
    member(tiene, Tokens),
    member(Entrenador, Tokens), entrenador(Entrenador),
    member(tipo, Tokens),
    member(Tipo, Tokens), (fuerte_contra(Tipo, _) ; fuerte_contra(_, Tipo)),
    !,
    findall(P, (tiene(Entrenador, P), tipo(P, Tipo)), Pokemones),
    format(string(Respuesta), "El entrenador ~w tiene estos pokemon de tipo ~w: ~w", [Entrenador, Tipo, Pokemones]).

% REGLA 4 DUEÑO/ENTRENADOR DE UN POKEMON (pregunta abierta)
interpretar(Tokens, Respuesta) :-
    (member('dueño', Tokens) ; member(entrenador, Tokens) ; member(quien, Tokens)),
    member(Pokemon, Tokens),
    pokemon(Pokemon),
    !,
    (   findall(E, tiene(E, Pokemon), Entrenadores), Entrenadores \= []
    ->  format(string(Respuesta), "Los entrenadores que tienen a ~w son: ~w", [Pokemon, Entrenadores])
    ;   format(string(Respuesta), "No existe un dueño registrado para ~w", [Pokemon])
    ).

% REGLA 5 TODOS LOS POKEMON DE UN ENTRENADOR (sin filtro)
interpretar(Tokens, Respuesta) :-
    member(tiene, Tokens),
    member(Entrenador, Tokens),
    entrenador(Entrenador),
    !,
    findall(P, tiene(Entrenador, P), Pokemones),
    format(string(Respuesta), "El entrenador ~w tiene a los siguientes pokemon: ~w", [Entrenador, Pokemones]).

% REGLA 6 POKEMON QUE COMPARTEN UN TIPO CON OTRO (self-join)
interpretar(Tokens, Respuesta) :-
    (member(comparte, Tokens) ; member(otro, Tokens)),
    member(tipo, Tokens),
    member(Pokemon, Tokens), pokemon(Pokemon),
    !,
    findall(P2, (tipo(Pokemon, T), tipo(P2, T), P2 \= Pokemon), Lista),
    list_to_set(Lista, Otros),
    format(string(Respuesta), "Pokemon que comparten un tipo con ~w: ~w", [Pokemon, Otros]).

% REGLA 7 TIPO DE UN POKEMON
interpretar(Tokens, Respuesta) :-
    member(tipo, Tokens),
    member(Pokemon, Tokens),
    pokemon(Pokemon),
    !,
    findall(T, tipo(Pokemon, T), Tipos),
    format(string(Respuesta), "El pokemon ~w es de tipo: ~w", [Pokemon, Tipos]).

% REGLA 8 DOBLE DEBILIDAD BOOLEANA 
interpretar(Tokens, Respuesta) :-
    member(doblemente, Tokens),
    (member(debil, Tokens) ; member('débil', Tokens)),
    member(Pokemon, Tokens), pokemon(Pokemon),
    member(Tipo, Tokens), (fuerte_contra(Tipo, _) ; fuerte_contra(_, Tipo)),
    !,
    (   doblemente_debil(Pokemon, Tipo)
    ->  format(string(Respuesta), "Si, ~w es doblemente debil contra ~w", [Pokemon, Tipo])
    ;   format(string(Respuesta), "No, ~w no es doblemente debil contra ~w", [Pokemon, Tipo])
    ).

% REGLA 9 DOBLE DEBILIDAD CONTRA UN TIPO 
interpretar(Tokens, Respuesta) :-
    member(doblemente, Tokens),
    (member(debil, Tokens) ; member('débil', Tokens)),
    member(Tipo, Tokens), (fuerte_contra(Tipo, _) ; fuerte_contra(_, Tipo)),
    !,
    findall(P, doblemente_debil(P, Tipo), Pokemones),
    format(string(Respuesta), "Los pokemon doblemente debiles contra ~w son: ~w", [Tipo, Pokemones]).

% REGLA 10 DOBLE DEBILIDAD TOTALMENTE ABIERTA 
interpretar(Tokens, Respuesta) :-
    member(doblemente, Tokens),
    (member(debil, Tokens) ; member('débil', Tokens)),
    !,
    findall(P-T, doblemente_debil(P, T), Pares),
    format(string(Respuesta), "Pares pokemon-tipo doblemente debiles: ~w", [Pares]).

% REGLA 11 DEBILIDAD BOOLEANA 
interpretar(Tokens, Respuesta) :-
    (member(debil, Tokens) ; member('débil', Tokens)),
    member(Pokemon, Tokens), pokemon(Pokemon),
    member(Tipo, Tokens), (fuerte_contra(Tipo, _) ; fuerte_contra(_, Tipo)),
    !,
    (   debil_contra(Pokemon, Tipo)
    ->  format(string(Respuesta), "Si, ~w es debil contra ~w", [Pokemon, Tipo])
    ;   format(string(Respuesta), "No, ~w no es debil contra ~w", [Pokemon, Tipo])
    ).

% REGLA 12 DEBILIDADES CONTRA UN TIPO 
interpretar(Tokens, Respuesta) :-
    (member(debil, Tokens) ; member('débil', Tokens)),
    member(Tipo, Tokens),
    (fuerte_contra(Tipo, _) ; fuerte_contra(_, Tipo)),
    !,
    findall(P, debil_contra(P, Tipo), Pokemones),
    format(string(Respuesta), "Los pokemon debiles contra el tipo ~w son: ~w", [Tipo, Pokemones]).

% REGLA 13 CONTRA QUE TIPOS ES DEBIL UN POKEMON 
interpretar(Tokens, Respuesta) :-
    (member(debil, Tokens) ; member('débil', Tokens)),
    member(Pokemon, Tokens), pokemon(Pokemon),
    !,
    findall(T, debil_contra(Pokemon, T), Tipos),
    format(string(Respuesta), "~w es debil contra los tipos: ~w", [Pokemon, Tipos]).

% REGLA 13B FUERTE CONTRA - BOOL
interpretar(Tokens, Respuesta) :-
    member(fuerte, Tokens),
    findall(T, (member(T, Tokens), (fuerte_contra(T, _) ; fuerte_contra(_, T))), TiposEncontrados),
    list_to_set(TiposEncontrados, [Tipo1, Tipo2 | _]),
    !,
    (   fuerte_contra(Tipo1, Tipo2)
    ->  format(string(Respuesta), "Si, ~w es fuerte contra ~w", [Tipo1, Tipo2])
    ;   format(string(Respuesta), "No, ~w no es fuerte contra ~w", [Tipo1, Tipo2])
    ).

% REGLA 13C FUERTE CONTRA - UN SOLO TIPO 
interpretar(Tokens, Respuesta) :-
    member(fuerte, Tokens),
    member(Tipo, Tokens), (fuerte_contra(Tipo, _) ; fuerte_contra(_, Tipo)),
    !,
    findall(T, fuerte_contra(Tipo, T), Tipos),
    format(string(Respuesta), "El tipo ~w es fuerte contra: ~w", [Tipo, Tipos]).

% REGLA 14 VULNERABILIDAD DE UN ENTRENADOR
interpretar(Tokens, Respuesta) :-
    member(vulnerable, Tokens),
    member(Entrenador, Tokens),
    entrenador(Entrenador),
    member(Tipo, Tokens),
    (fuerte_contra(Tipo, _) ; fuerte_contra(_, Tipo)),
    !,
    (   entrenador_vulnerable(Entrenador, Tipo)
    ->  format(string(Respuesta), "Si! El entrenador ~w es vulnerable a ataques de tipo ~w", [Entrenador, Tipo])
    ;   format(string(Respuesta), "No, el entrenador ~w no presenta vulnerabilidad directa a ese tipo", [Entrenador])
    ).

% REGLA 15 VENTAJA ENTRE DOS POKEMON
interpretar(Tokens, Respuesta) :-
    (member(ventaja, Tokens) ; member(ganarle, Tokens)),
    append(_, [P1 | Rest], Tokens),
    (member(contra, Rest) ; member(sobre, Rest)),
    append(_, [P2 | _], Rest),
    pokemon(P1),
    pokemon(P2),
    !,
    (   tiene_ventaja(P1, P2)
    ->  format(string(Respuesta), "Si! ~w tiene ventaja sobre ~w", [P1, P2])
    ;   format(string(Respuesta), "No, ~w no tiene ventaja directa sobre ~w", [P1, P2])
    ).

% REGLA 16 QUE POKEMON TIENEN VENTAJA SOBRE UNO DADO
interpretar(Tokens, Respuesta) :-
    (member(ventaja, Tokens) ; member(ganarle, Tokens)),
    (member(contra, Tokens) ; member(sobre, Tokens)),
    member(Pokemon, Tokens),
    pokemon(Pokemon),
    !,
    findall(P, tiene_ventaja(P, Pokemon), Pokemones),
    format(string(Respuesta), "Los pokemon con ventaja sobre ~w son: ~w", [Pokemon, Pokemones]).

% REGLA 17 SALUDO
interpretar(Tokens, Respuesta) :-
    (member(hola, Tokens) ; member(buenas, Tokens)),
    !,
    Respuesta = "Hola! Preguntame por entrenadores, tipos, debilidades o ventajas de los pokemon.".

% RESPUESTA POR DEFECTO
interpretar(_, 'No logro entender tu pregunta :(. Prueba preguntando por tipos, quien tiene a un pokemon, o debilidades.').