transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160, d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat, 2015)).
transporte(ana, auto(fiesta, ford, 2014)).
transporte(roberto, auto(qubo, fiat, 2015)).
manejaLento(manuel).
manejaLento(ana).

%1-

%transporte(Quien, auto(_, fiat, _)).

%2-

tardaMucho(Persona) :- transporte(Persona, camina).
tardaMucho(Persona) :- transporte(Persona, auto(_, _, _)), manejaLento(Persona).

%3-

viajaEnColectivo(Persona) :- transporte(Persona, colectivo(_)).
viajaEnColectivo(Persona) :- transporte(Persona, colectivo(_, _)).