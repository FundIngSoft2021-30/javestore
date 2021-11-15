//@dart=2.9
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Descuento> ResenaFromJson(String str) =>
    List<Descuento>.from(json.decode(str).map((x) => Descuento.fromJson(x)));

class Descuento {
  Timestamp fechaFinal;
  Timestamp fechaInicio;
  String imagenPromocion;
  double porcentaje;
  List<dynamic> productos;

  Descuento(
      {this.fechaFinal,
      this.fechaInicio,
      this.imagenPromocion,
      this.porcentaje,
      this.productos});

  @override
  String toString() {
    return '{'; // fechaFinal: $fechaFinal, fechaInicio: $fechaInicio, imagenPromocion: $imagenPromocion, nombre: $imagenPromocion }';
  }

  factory Descuento.fromJson(Map<String, dynamic> json) => Descuento(
      fechaFinal: json["fechaFinal"],
      fechaInicio: json["fechaInicio"],
      imagenPromocion: json["imagenPromocion"],
      porcentaje: json["porcentaje"],
      productos: json["productos"]);
}
