import 'package:trip_control_app/utils/tuple.dart';

Tuple calculoRentabilidad(int cantU, double pesoT, double pagoM2,
    double precioM1, double cambioM1, double cambioM2) {
  double precioTotalM1 = precioM1 * cantU;
  double precioCompraDolares = pagoM2 / cambioM2;
  double precioVentaDolares = precioTotalM1 / cambioM1;
  double rentabilidadReal = precioVentaDolares - precioCompraDolares;

  double rentabilidadPorcentual =
      ((precioVentaDolares - precioCompraDolares) * 100) / precioCompraDolares;

  double pesoU = pesoT / cantU;
  double cantUKg = 1 / pesoU;
  double costoUM2 = pagoM2 / cantU;
  double costoM2Kg = cantUKg * costoUM2;
  double precioM1Kg = cantUKg * precioM1;
  double rentabilidadKg = precioM1Kg / cambioM1 - costoM2Kg / cambioM2;

  return Tuple(
      T: rentabilidadReal,
      K: Tuple<double, double>(T: rentabilidadKg, K: rentabilidadPorcentual));
}
