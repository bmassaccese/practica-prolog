%domicilio(Persona, Lugar)
domicilio(agatha, dreadbury).
domicilio(charles, dreadbury).
domicilio(carnicero, dreadbury).

matoA(agatha, Asesino) :- domicilio(Asesino, dreadbury), odiaA(Asesino, agatha), not(esMasRico(Asesino, agatha)).

odiaA(charles, OtraPersona) :- not(odiaA(agatha, OtraPersona)).

odiaA(agatha, OtraPersona) :- domicilio(OtraPersona, dreadbury), OtraPersona \= carnicero.
odiaA(carnicero, OtraPersona) :- domicilio(OtraPersona, dreadbury), OtraPersona \= carnicero.

esMasRico(Persona, agatha) :- domicilio(Persona, dreadbury), not(odiaA(carnicero, Persona)).