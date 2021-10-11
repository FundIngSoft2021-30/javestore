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
  String calificacion;
  String cantidad;

  Producto({
    this.codigo,
    this.descripcion,
    this.nombre,
    this.activo,
    this.precio,
    this.calificacion,
    this.cantidad,
  });
  @override
  String toString() {
    return "id:" + this.codigo + "  name:" + this.nombre;
  }

// Connected[{"id":,"cantidad":,"nombre":,"descripcion":","Precio":"estado":,"Categoriaid":,"Usuarioid":"1","imagen":null}
  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
      codigo: json["id"],
      cantidad: json["cantidad"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      precio: json["Precio"],
      activo: json["estado"]);
}
