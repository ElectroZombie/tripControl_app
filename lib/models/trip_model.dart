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
  double? kilosTotales;
  double? rentabilidad; //Dollar
  double? rentabilidadXKilo;
  double? rentabilidadPorcentual;
  String? nombrePais;
  String? fechaInicioViaje;
  String? fechaFinalViaje;

  TripModel(
      {required this.tripID,
      required this.tripName,
      required this.activo,
      required this.nombrePais,
      required this.fechaInicioViaje,
      this.fechaFinalViaje,
      this.coin1Price,
      this.coin2Price,
      this.gastoCompras,
      this.otrosGastos,
      this.gananciaComprasReal,
      this.gananciaComprasXKilo,
      this.gastoComprasXKilo,
      this.kilosTotales,
      this.rentabilidad,
      this.rentabilidadXKilo,
      this.rentabilidadPorcentual});

  static TripModel nullTrip() {
    return TripModel(
        tripID: -1,
        tripName: "",
        activo: 0,
        fechaInicioViaje: "",
        nombrePais: "");
  }

  Map<String, dynamic> toMap() {
    return {
      'id_viaje': tripID,
      'nombre_viaje': tripName,
      'activo': activo,
      'precio_M1': coin1Price,
      'precio_M2': coin2Price,
      'nombre_pais': nombrePais,
      'fecha_inicio_viaje': fechaInicioViaje,
      'fecha_final_viaje': fechaFinalViaje
    };
  }

  void setCoin1Price(double coin) {
    double gananciaXCoin1 = gananciaComprasReal! * coin1Price!;

    coin1Price = coin;
    gananciaComprasReal = gananciaXCoin1 / coin1Price!;
    gananciaComprasXKilo = gananciaComprasReal! / kilosTotales!;

    _actualizarRentabilidad();
  }

  void setCoin2Price(double coin) {
    double gastoXCoin2 = gastoCompras! * coin2Price!;

    coin2Price = coin;
    gastoCompras = gastoXCoin2 / coin2Price!;
    gastoComprasXKilo = gastoCompras! / kilosTotales!;

    _actualizarRentabilidad();
  }

  void _actualizarRentabilidad() {
    gastoTotal = gastoCompras! + otrosGastos!;

    rentabilidad = gananciaComprasReal! - gastoTotal;
    rentabilidadXKilo = gananciaComprasXKilo! - gastoComprasXKilo!;
    rentabilidadPorcentual =
        ((gananciaComprasReal! - gastoTotal) * 100) / gastoTotal;
  }

  void addGasto(double gasto) {
    otrosGastos = otrosGastos! + gasto;

    _actualizarRentabilidad();
  }

  void addCompra(CompraModel compra) {
    gastoCompras = gastoCompras! + compra.compraPrecio / coin2Price!;

    gananciaComprasReal = gananciaComprasReal! +
        (compra.cantU * compra.ventaCUPXUnidad) / coin1Price!;

    kilosTotales = kilosTotales! + compra.pesoT;

    gastoComprasXKilo = gastoCompras! / kilosTotales!;

    gananciaComprasXKilo = gananciaComprasReal! / kilosTotales!;

    _actualizarRentabilidad();
  }

  void deleteCompra(CompraModel compra) {
    gastoCompras = gastoCompras! - compra.compraPrecio / coin2Price!;

    gananciaComprasReal = gananciaComprasReal! -
        (compra.cantU * compra.ventaCUPXUnidad) / coin1Price!;

    kilosTotales = kilosTotales! - compra.pesoT;

    gastoComprasXKilo = gastoCompras! / kilosTotales!;

    gananciaComprasXKilo = gananciaComprasReal! / kilosTotales!;

    _actualizarRentabilidad();
  }

  void deleteGasto(double gasto) {
    otrosGastos = otrosGastos! - gasto;

    _actualizarRentabilidad();
  }
}
