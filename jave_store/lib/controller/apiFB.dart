// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Entidades/Usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ApiFB api = ApiFB();
  var x = await api.getInfoUser("Jkes9lQxd3fLqFwg5kbwefZ08rz2");
  print(x);
}

class ApiFB extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Categoria>> getCategories() async {
    List<Categoria> c = [];
    final docs = await _firestore
        .collection('Category')
        .get()
        .then((value) => value.docs);
    for (var doc in docs) {
      c.add(Categoria(nombre: doc.id));
    }
    return c;
  }

  Future<Usuario> getInfoUser(String id) async {
    final u = await _firestore.collection('Users').doc(id).get();
    return Usuario.fromFirestore(u);
  }

  Future<String> getImage(BuildContext context, String igName) async {
    var x = await FirebaseStorage.instance.ref("Libros").listAll();
    final url = await x.items[0].getDownloadURL();
    return url;
  }

  Future<List<Producto>> getProducts() async {
    List<Producto> p = [];
    final QuerySnapshot result = await _firestore.collection('Producto').get();
    final List<DocumentSnapshot> documents = result.docs;
    for (var doc in documents) {
      p.add(Producto(
          activo: doc['available'],
          nombre: doc.id,
          precio: doc['price'],
          descripcion: doc['description'],
          calificacion: doc['rate'],
          cantidad: doc['quantity'],
          categoria: doc['category'],
          imagen: doc['image']));
    }
    return p;
  }

  Future<List<Producto>> getProductsByCategory(int index) async {
    String categoria =
        await this.getCategories().then((value) => value[index].nombre);
    List<Producto> p = [];
    final result = await _firestore.collection('Producto').get().then((value) =>
        value.docs
            .where((element) => element.data()['category'] == categoria)
            .toList());
    for (var doc in result) {
      p.add(Producto(
          activo: doc['available'],
          nombre: doc.id,
          precio: doc['price'],
          descripcion: doc['description'],
          calificacion: doc['rate'],
          cantidad: doc['quantity'],
          categoria: doc['category'],
          imagen: doc['image']));
    }
    return p;
  }

  Future<List<String>> getSuggestions() async {
    final QuerySnapshot result = await _firestore.collection('Producto').get();
    final List<DocumentSnapshot> documents = result.docs;
    List<String> rt = [];
    for (var doc in documents) {
      rt.add(doc.id);
    }
    return rt;
  }
}