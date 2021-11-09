//@dart=2.9
import 'dart:convert';

List<Pedido> ResenaFromJson(String str) =>
    List<Pedido>.from(json.decode(str).map((x) => Pedido.fromJson(x)));

class Pedido {
  String carritoId;
  DateTime fecha;
  String instrucciones;
  String metodoEntrega;
  List<String> productos;
  double total;

  Pedido(
      {this.carritoId,
      this.fecha,
      this.instrucciones,
      this.metodoEntrega,
      this.productos,
      this.total});

  @override
  String toString() {
    return '{'; // fechaFinal: $fechaFinal, fechaInicio: $fechaInicio, imagenPromocion: $imagenPromocion, nombre: $imagenPromocion }';
  }

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
      carritoId: json["carritoId"],
      fecha: json["fecha"],
      instrucciones: json["instrucciones"],
      metodoEntrega: json["metodoEntrega"],
      productos: json["productos"],
      total: json["total"]);
}
