import 'package:trip_control_app/models/compra_model.dart';

class TripModel {
  int tripID;
  String tripName;
  double? coin1Price;
  double? coin2Price;
  int activo = 1;

  double gastoTotal = 0.0; //Dollar
  double? gastoCompras; //Coin2-Dollar
  double? otrosGastos; //Dollar
  double? gananciaComprasReal; //Coin1-Dollar
  double? gananciaComprasXKilo; //Coin1-Dollar
  double? gastoComprasXKilo;
  double? rentabilidad; //Dollar
  double? rentabilidadXKilo;
  double? rentabilidadPorcentual;

  //List<GastoModel> gastos = List.empty();
  //List<CompraModel> compras = List.empty();

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

  static TripModel nullTrip() {
    return TripModel(tripID: -1, tripName: "", activo: 0);
  }

  Map<String, dynamic> toMap() {
    return {
      'id_viaje': tripID,
      'nombre_viaje': tripName,
      'activo': activo,
      'precio_M1': coin1Price,
      'precio_M2': coin2Price,
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

  void addGasto(double gasto) {
    //gastos.add(gasto);
    otrosGastos = otrosGastos! + gasto;

    _actualizarRentabilidad();
  }

  void addCompra(CompraModel compra) {
    //compras.add(compra);

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
}
