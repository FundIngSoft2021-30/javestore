// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Entidades/Resena.dart';
import 'package:jave_store/Entidades/Usuario.dart';

class resenasController {
  FirebaseFirestore _firestore;

  resenasController(FirebaseFirestore firestore) {
    this._firestore = firestore;
  }

  Future<List<Resena>> getComentarios(String idProducto) async {
    List<Resena> c = [];
    final QuerySnapshot result = await _firestore
        .collection('Resena')
        .where('idProducto', isEqualTo: idProducto)
        .get();
    final List<DocumentSnapshot> docs = result.docs;

    for (var doc in docs) {
      c.add(Resena(
          avatarImagen: doc['avatarImagen'],
          comentario: doc['comentario'],
          idProducto: doc['idProducto'],
          nombre: doc['nombre']));
      print(c.elementAt(0).comentario);
    }
    print(c.length);
    return c;
  }

  Future<bool> insertResena(Resena r) async {
    await _firestore
        .collection('Resena')
        .add({
          'avatarImagen': r.avatarImagen,
          'comentario': r.comentario,
          'idProducto': r.idProducto,
          'nombre': r.nombre
        })
        .then((value) => print("Usuario agregado"))
        .catchError((error) => print("Fallo inserción: $error"));
  }
}
