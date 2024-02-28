import 'package:trip_control_app/models/compra_model.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/utils/busqueda_binaria.dart';

class TripModel {
  int tripID;
  String tripName;
  double? coin1Price;
  double? coin2Price;
  bool activo = true;

  double gastoTotal = 0.0; //Dollar
  double? gastoCompras; //Coin2-Dollar
  double? otrosGastos; //Dollar
  double? gananciaComprasReal; //Coin1-Dollar
  double? gananciaComprasXKilo; //Coin1-Dollar
  double? gastoComprasXKilo;
  double? rentabilidad; //Dollar
  double? rentabilidadXKilo;
  double? rentabilidadPorcentual;

  List<GastoModel> gastos = List.empty();
  List<CompraModel> compras = List.empty();

  TripModel(
      {required this.tripID,
      required this.tripName,
      required this.activo,
      this.coin1Price,
      this.coin2Price,
      this.gastoCompras,
      this.otrosGastos,
      this.gananciaComprasReal,
      this.gananciaComprasXKilo,
      this.gastoComprasXKilo,
      this.rentabilidad,
      this.rentabilidadXKilo,
      this.rentabilidadPorcentual});

  Map<String, dynamic> toMap() {
    return {
      'tripID': tripID,
      'tripName': tripName,
      'activo': activo,
      'coin1Price': coin1Price,
      'coin2Price': coin2Price,
      'gastoTotal': gastoTotal,
      'otrosGastos': otrosGastos,
      'gastoCompras': gastoCompras,
      'gananciaComprasReal': gananciaComprasReal,
      'gananciaComprasXKilo': gananciaComprasXKilo,
      'gastoComprasXKilo': gastoComprasXKilo,
      'rentabilidad': rentabilidad,
      'rentabilidadXKilo': rentabilidadXKilo,
      'rentabilidadPorcentual': rentabilidadPorcentual,
      'gastos': gastos,
      'compras': compras
    };
  }

  void setCoin1Price(double coin) {
    coin1Price = coin;
  }

  void setCoin2Price(double coin) {
    coin2Price = coin;
  }

  void _actualizarRentabilidad() {
    gastoTotal = gastoCompras! + otrosGastos!;

    rentabilidad = gananciaComprasReal! - gastoTotal;
    rentabilidadXKilo =
        gananciaComprasXKilo! - gastoComprasXKilo! - otrosGastos!;
    rentabilidadPorcentual = (gananciaComprasReal! * 100) / gastoTotal;
  }

  void addGasto(GastoModel gasto) {
    gastos.add(gasto);
    otrosGastos = otrosGastos! + gasto.gastoMoney;

    _actualizarRentabilidad();
  }

  void deleteGasto(GastoModel gasto) {
    int ini = busquedaBinaria(gastos, gasto);
    gastos.removeAt(ini);
    otrosGastos = otrosGastos! - gasto.gastoMoney;

    _actualizarRentabilidad();
  }

  void updateGasto(GastoModel gasto) {
    int ini = busquedaBinaria(gastos, gasto);

    otrosGastos = otrosGastos! - gastos[ini].gastoMoney;
    gastos[ini] = gasto;
    otrosGastos = otrosGastos! + gastos[ini].gastoMoney;

    _actualizarRentabilidad();
  }

  void addCompra(CompraModel compra) {
    compras.add(compra);

    gastoCompras = gastoCompras! + compra.compraPrecio / coin2Price!;

    gananciaComprasReal = gananciaComprasReal! +
        (compra.cantU * compra.ventaCUPXUnidad) / coin1Price!;

    gastoComprasXKilo = gastoComprasXKilo! +
        (compra.compraPrecio / coin2Price!) * (1 / compra.pesoT);

    gananciaComprasXKilo = gananciaComprasXKilo! +
        (((compra.cantU * compra.ventaCUPXUnidad) / coin1Price!) *
            ((compra.compraPrecio / coin2Price!) * (1 / compra.pesoT)) /
            (compra.compraPrecio / coin2Price!));

    _actualizarRentabilidad();
  }

  void deleteCompra(CompraModel compra) {
    int ini = busquedaBinaria(compras, compra);

    gastoCompras = gastoCompras! - compra.compraPrecio / coin2Price!;

    gananciaComprasReal = gananciaComprasReal! -
        (compra.cantU * compra.ventaCUPXUnidad) / coin1Price!;

    gastoComprasXKilo = gastoComprasXKilo! -
        (compra.compraPrecio / coin2Price!) * (1 / compra.pesoT);

    gananciaComprasXKilo = gananciaComprasXKilo! -
        (((compra.cantU * compra.ventaCUPXUnidad) / coin1Price!) *
            ((compra.compraPrecio / coin2Price!) * (1 / compra.pesoT)) /
            (compra.compraPrecio / coin2Price!));

    compras.removeAt(ini);

    _actualizarRentabilidad();
  }

  void updateCompra(CompraModel compra) {
    int ini = busquedaBinaria(compras, compra);

    gastoCompras = gastoCompras! - compras[ini].compraPrecio / coin2Price!;

    gananciaComprasReal = gananciaComprasReal! -
        (compras[ini].cantU * compras[ini].ventaCUPXUnidad) / coin1Price!;

    gastoComprasXKilo = gastoComprasXKilo! -
        (compras[ini].compraPrecio / coin2Price!) * (1 / compras[ini].pesoT);

    gananciaComprasXKilo = gananciaComprasXKilo! -
        (((compras[ini].cantU * compras[ini].ventaCUPXUnidad) / coin1Price!) *
            ((compras[ini].compraPrecio / coin2Price!) *
                (1 / compras[ini].pesoT)) /
            (compras[ini].compraPrecio / coin2Price!));

    compras[ini] = compra;

    gastoCompras = gastoCompras! + compras[ini].compraPrecio / coin2Price!;

    gananciaComprasReal = gananciaComprasReal! +
        (compras[ini].cantU * compras[ini].ventaCUPXUnidad) / coin1Price!;

    gastoComprasXKilo = gastoComprasXKilo! +
        (compras[ini].compraPrecio / coin2Price!) * (1 / compras[ini].pesoT);

    gananciaComprasXKilo = gananciaComprasXKilo! +
        (((compras[ini].cantU * compras[ini].ventaCUPXUnidad) / coin1Price!) *
            ((compras[ini].compraPrecio / coin2Price!) *
                (1 / compras[ini].pesoT)) /
            (compras[ini].compraPrecio / coin2Price!));

    _actualizarRentabilidad();
  }
}
