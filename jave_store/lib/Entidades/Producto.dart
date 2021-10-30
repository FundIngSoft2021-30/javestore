//@dart=2.9
import 'dart:convert';

List<Producto> ProductoFromJson(String str) =>
    List<Producto>.from(json.decode(str).map((x) => Producto.fromJson(x)));

class Producto {
  String descripcion;
  String categoria;
  String nombre;
  bool activo;
  double precio;
  int calificacion;
  int cantidad;
  String imagen;

  Producto({
    this.imagen,
    this.descripcion,
    this.nombre,
    this.activo,
    this.precio,
    this.categoria,
    this.calificacion,
    this.cantidad,
  });
  @override
  String toString() {
    return 'Producto{descripcion: $descripcion, nombre: $nombre, activo: $activo, precio: $precio, calificacion: $calificacion, cantidad: $cantidad}';
  }

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
      cantidad: json["amount"],
      nombre: json["name"],
      descripcion: json["description"],
      precio: json["price"],
      calificacion: json["rate"],
      imagen: json["image"],
      activo: json["available"]);
}
