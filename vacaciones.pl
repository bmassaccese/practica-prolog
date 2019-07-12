lugar(marDelPlata, hotel(elViajante, 4, 1500)).
lugar(marDelPlata, hotel(casaNostra, 3, 1000)).
lugar(lasToninas, hotel(holidays, 2, 500)).
lugar(tandil, quinta(amanecer, pileta, 650)).
lugar(bariloche, carpa(80)).
lugar(laFalda, casa(pileta, 600)).
lugar(rosario, casa(garage, 400)).

puedeGastar(ana, 4, 10000).
puedeGastar(hernan, 5, 8000).
puedeGastar(mario, 5, 4000).

%puedeIr(Persona, LugarVacaciones, Alojamiento) :- plataDiaria(Persona, Cantidad), lugar(LugarVacaciones,)
    
plataDiaria(Persona, Cantidad) :- puedeGastar(Persona, Dias, TotalPlata), Cantidad is (TotalPlata / Dias).