//@dart=2.9
import 'dart:convert';
List<Categoria> CategoriaFromJson(String str) =>
    List<Categoria>.from(
        json.decode(str).map((x) => Categoria.fromJson(x)));

class Categoria {
  String nombre;

  Categoria({
    this.nombre,

  });
  @override
  String toString() {
    return  "  name:" + this.nombre;
  }

// Connected[{"id":,"cantidad":,"nombre":,"descripcion":","Precio":"estado":,"Categoriaid":,"Usuarioid":"1","imagen":null}
  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
      nombre: json["nombre"]);
}
