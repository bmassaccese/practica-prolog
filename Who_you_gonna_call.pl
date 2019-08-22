% 1.
%
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% 2.

% tiene(Persona, Herramienta).

tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(egon, plumero).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).

satisfaceNecesidad(Persona, Herramienta) :- tiene(Persona, Herramienta).
satisfaceNecesidad(Persona, aspiradora(PotenciaRequerida)) :-
    	tiene(Persona, aspiradora(Potencia)), Potencia >= PotenciaRequerida.


% 3.

puedeHacerTarea(Persona, _) :- tiene(Persona, varitaDeNeutrones).

puedeHacerTarea(Persona, Tarea) :-
    tiene(Persona, _),
    herramientasRequeridas(Tarea, ListaDeHerramientas),
    forall(member(Herramienta, ListaDeHerramientas), satisfaceNecesidad(Persona, Herramienta)).

% 4.

%precioPorTareaPedida(Cliente, Tarea, CantidadMetros2) :-
 %   precio(Tarea, PrecioMetro2).

%precio(Tarea, PrecioMetro2).


precioACobrar(Cliente, PrecioACobrar) :-
    tareaPedida(Cliente, _ , _),
    findall(Precio, precioPorTarea(Cliente, _, Precio) , ListaPrecios),
    sumlist(ListaPrecios, PrecioACobrar).

precioPorTarea(Cliente, Tarea, PrecioACobrar) :-
	precioPorTareaPedida(Cliente, Tarea, CantidadMetros2),
	precio(Tarea, PrecioMetro2), PrecioACobrar is CantidadMetros2 * PrecioMetro2.


precioACobrar(Cliente, PrecioACobrar):-
	tareaPedida(Cliente, _, _),
	findall(Precio, precioPorTareaPedida(Cliente, _, Precio),
		ListaPrecios),
	sumlist(ListaPrecios, PrecioACobrar).

%Recordemos que precioACobrar es para saber la suma del precio de
%todas las tareas que solicitó un cliente


precioPorTareaPedida(Cliente, Tarea, Precio):-
	tareaPedida(Cliente, Tarea, Metros),
	precio(Tarea, PrecioPorMetro),
	Precio is PrecioPorMetro * Metros.
    
% 5.

aceptaPedido(Trabajador, Cliente) :-
    puedeHacerPedido(Trabajador, Cliente),
    estaDispuesto(Trabajador, Cliente).

puedeHacerPedido(Trabajador, Cliente) :-
