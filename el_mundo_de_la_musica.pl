% El mundo de la música

% disco(artista, nombreDelDisco, cantidad, año).

disco(floydRosa, elLadoBrillanteDeLaLuna, 1000000, 1973).
disco(tablasDeCanada, autopistaTransargentina, 500, 2006).
disco(rodrigoMalo, elCaballo, 5000000, 1999).
disco(rodrigoMalo, loPeorDelAmor, 50000000, 1996).
disco(rodrigoMalo, loMejorDe, 50000000, 2018).
disco(losOportunistasDelConurbano, ginobili, 5, 2018).
disco(losOportunistasDelConurbano, messiMessiMessi, 5, 2018).
disco(losOportunistasDelConurbano, marthaArgerich, 15, 2019).

%manager(artista, manager).

manager(flydRosa, normal(15)).
manager(tablasDeCanada, buenaOnda(cachito, canada)).
manager(rodrigoMalo, estafador).

% normal(porcentajeComision)
% buenaOnda(nombre, lugar)
% estafador


% 1.

clasico(Artista) :- disco(Artista, loMejorDe, _, _).

clasico(Artista) :- disco(Artista, _, Cantidad, _), Cantidad > 1000000.

% 2.

totalVentas(Artista, TotalDeVentas) :- 
    artista(Artista),
    findall(Ventas, disco(Artista, _, Ventas, _), ListaDeVentas),
    sum_list(ListaDeVentas, TotalDeVentas).

artista(Artista) :- disco(Artista, _, _, _).

% 3.

gananciaArtista(Artista, GananciaTotal) :-
    totalVentas(Artista, TotalVentas),
    descuentoPorManager(Artista, Descuento),
    GananciaArtista is TotalVentas * 10,
    GananciaTotal is GananciaArtista * 10 - (GananciaArtista * Descuento) / 100.

descuentoPorManager(Artista, Descuento) :-
    manager(Artista, Manager),
    porcentajeDescuento(Manager, Descuento).


porcentajeDescuento(Artista, 0) :- not(manager(Artista, _)).

porcentajeDescuento(normal(Descuento), Descuento).

porcentajeDescuento(estafador, 100).

porcentajeDescuento(buenaOnda(_, Lugar), Descuento) :- porcentajeLugar(Lugar, Descuento).

porcentajeLugar(canada, 5).

porcentajeLugar(mexico, 15).

% 4.

namberuan(Artista, Año) :-
	esIndependiente(Artista, Cantidad, Año),
    forall(esIndependiente(OtroArtista, OtraCantidad, Año), Cantidad >= OtraCantidad).

% sin usar el forall
% not((esIndependiente(OtroArtista, OtraCantidad, Año), Cantidad < OtraCantidad))
    
esIndependiente(Artista, Cantidad, Año) :-
    disco(Artista, _, Cantidad, Año),
    not(manager(Artista, _)).
