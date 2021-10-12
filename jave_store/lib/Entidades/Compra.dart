//@dart=2.9
import 'dart:convert';

List<Compra> CompraFromJson(String str) =>
    List<Compra>.from(json.decode(str).map((x) => Compra.fromJson(x)));

class Compra {
  String descripcion;
  String nombre;
  String activo;
  String codigo;
  String precio;
  String calificacion;
  String cantidad;

  Compra({
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
  factory Compra.fromJson(Map<String, dynamic> json) => Compra(
      codigo: json["id"],
      cantidad: json["cantidad"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      precio: json["Precio"],
      activo: json["estado"]);
}
