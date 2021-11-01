//@dart=2.9
import 'dart:convert';

List<Resena> ResenaFromJson(String str) =>
    List<Resena>.from(json.decode(str).map((x) => Resena.fromJson(x)));

class Resena {
  String avatarImagen;
  String comentario;
  String idProducto;
  String nombre;

  Resena({this.nombre, this.avatarImagen, this.comentario, this.idProducto});

  @override
  String toString() {
    return '{ avatarImagen: $avatarImagen, comentario: $comentario, idProducto: $idProducto, nombre: $nombre }';
  }

  factory Resena.fromJson(Map<String, dynamic> json) => Resena(
      avatarImagen: json["avatarImagen"],
      comentario: json["comentario"],
      idProducto: json["idProducto"],
      nombre: json["nombre"]);
}
