//@dart=2.9
import 'dart:convert';

List<Producto> ProductoFromJson(String str) =>
    List<Producto>.from(json.decode(str).map((x) => Producto.fromJson(x)));

class Producto {
  String descripcion;
  String nombre;
  String activo;
  String codigo;
  String precio;
  String imagen;
  String calificacion;
  String cantidad;

  Producto({
    this.codigo,
    this.descripcion,
    this.nombre,
    this.activo,
    this.precio,
    this.imagen,
    this.calificacion,
    this.cantidad,
  });
  @override
  String toString() {
    return "id:" + this.codigo + "  name:" + this.nombre;
  }

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
      codigo: json["id"],
      cantidad: json["cantidad"],
      imagen: json["imagen"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      precio: json["precio"],
      activo: json["estado"]);
}
