//@dart=2.9
import 'dart:convert';

import 'package:jave_store/Entidades/Cuenta.dart';

List<Usuario> UsuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

class Usuario extends Cuenta {
  String nombre;
  String apellido;
  String direccion;
  String numero;

  Usuario({
    this.nombre,
    this.apellido,
    this.direccion,
    this.numero,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        numero: json["numero"],
        nombre: json["nombre"],
        apellido: json["apellido"],
      );
}
