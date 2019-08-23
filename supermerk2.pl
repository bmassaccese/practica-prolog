% Supermerk2

% precioUnitario(producto, precio).

precioUnitario(arroz(gallo), 65).
precioUnitario(lacteo(laSerenisima, leche), 46).
precioUnitario(lacteo(lasTresNinias, leche), 34).
precioUnitario(lacteo(laSerenisima, crema), 34).
precioUnitario(lacteo(gandara, queso(gouda)), 213).
precioUnitario(lacteo(vacalin, queso(mozzarella)), 212).
precioUnitario(salchichas(vienisima, 12), 129).
precioUnitario(salchichas(vienisima, 6), 85).
precioUnitario(salchichas(granjaDelSol, 8), 95).

% 1.

% compro(cliente, producto, cantidad).

compro(juan, lacteo(laSerenisima, leche), 1).
compro(juan, lacteo(laSerenisima, crema), 1).

compro(flora, salchichas(vienisima, 12), 2).
compro(flora, salchichas(granjaDelSol, 8), 1).

% 2.

clienteFiel(Cliente, Marca) :-
	compro(Cliente, _),
    forall()
    
% 3.

% primeraMarca(marca).    
    
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

% descuento(producto, porcntajeDescuento).

descuento(arroz(luchetti), 15).
descuento(salchichas(granjaDelSol, 8), 5).
descuento(lacteo(_, leche), 20).
descuento(lacteo(Marca, queso(_)), 20) :- primeraMarca(Marca).

cliente(Cliente) :- compra(Cliente, _, _).

% 4.

noSabeAhorrar(Cliente) :-
    cliente(Cliente),
    not((compra(Cliente, Producto, _), descuento(Producto, _))).

% 5.

expertoEnAhorro(Cliente) :-
    cliente(Cliente),
    forall(primeraMarcaConDescuento(Producto), compra(Cliente, Producto)).

primeraMarcaConDescuento(Producto) :-
    precioUnitario(Producto, _),
    esDeMarca(Producto, Marca),
    primeraMarca(Marca),
    descuento(Producto, _).

esDeMarca(arroz(Marca), Marca).
esDeMarca(lacteo(Marca, _), Marca).
esDeMarca(salchichas(Marca, _), Marca).

% 6.

totalAPagar(Cliente, MontoTotal) :-
    cliente(Cliente),
    findall(Monto, calculoDeMonto(Cliente, Monto), ListaMontos), sum_list(ListaMontos, MontoTotal).

calculoDeMonto(Cliente, Precio) :-
	compro(Cliente, Producto),
    precioFinal(Producto, Precio).

precioFinal(Producto, Precio) :-
    precioUnitario(Producto, ValorSinDescuento),
    descuento(Producto, Descuento),
    Precio is ValorSinDescuento - (ValorSinDescuento*Descuento)/100.

precioFinal(Producto, Precio) :-
    precioUnitario(Producto, Precio),
    not(descuento(Producto, _)).


% 7.

duenio(laSerenisima, gandara).
duenio(gandara, vacalin).

marca(Empresa) :-

provee(Empresa, ListaDeProductos) :-
    marca(Empresa),
    findall(Producto, perteneceA(Producto, Empresa), ListaDeProductos).

perteneceA(Producto, Empresa) :-
    precioUnitario(Producto, _),
	esDeMarca(Producto, Empresa).

perteneceA(Producto, Empresa) :-
    precioUnitario(Producto, _),
	not(esDeMarca(Producto, OtraEmpresa)),
    esDuenio(Empresa, OtraEmpresa),
    perteneceA(Producto, OtraEmpresa).

esduenio(Empresa, OtraEmpresa) :- duenio(Empresa, OtraEmpresa),
    
esDuenio(Empresa, OtraEmpresa) :- duenio(Empresa, AlgunaEmpresa), esDuenio(AlgunaEmpresa, OtraEmpresa).
