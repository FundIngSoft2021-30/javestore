//@dart=2.9
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

List<Usuario> UsuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

class Usuario with ChangeNotifier {
  String nombre;
  String url;
  String email;
  String apellido;
  String direccion;
  int numero;

  Usuario({
    this.email,
    this.nombre,
    this.apellido,
    this.direccion,
    this.numero,
    this.url,
  });

  @override
  String toString() {
    return 'Usuario{nombre: $nombre, url: $url, email: $email, apellido: $apellido, direccion: $direccion, numero: $numero}';
  }

  factory Usuario.fromFirestore(DocumentSnapshot json) {
    Map doc = json.data();
    return Usuario(
      nombre: doc["name"],
      apellido: doc["surname"],
      direccion: doc["address"],
      numero: doc["number"],
      url: doc["url"],
      email: doc["email"],
    );
  }
  void setFromFirestore(DocumentSnapshot json) {
    Map doc = json.data();
    this.nombre = doc["name"];
    this.apellido = doc["surname"];
    this.direccion = doc["address"];
    this.numero = doc["number"];
    this.url = doc["url"];
    this.email = doc["email"];
    notifyListeners();
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        numero: json["numero"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        url: json["url"],
      );
}
