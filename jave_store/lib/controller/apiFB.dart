// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Descuento.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Entidades/Usuario.dart';
import 'package:jave_store/controller/Producto/resenasController.dart';
import 'package:jave_store/Entidades/Resena.dart';
import 'Producto/descuentosController.dart';
import 'Producto/resenasController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ApiFB api = ApiFB();
  await api.get_cart("zDPg5UAyVCbc0qgLQqekBWhUk4N2");
}

class ApiFB extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final resenas = new resenasController(FirebaseFirestore.instance);

  final descuentos = new descuentosController(FirebaseFirestore.instance);

  Future<List<Resena>> getresenas(idProducto) async {
    return await resenas.getComentarios(idProducto);
  }

  void insertarResena(Resena resena) async {
    await resenas.insertResena(resena);
  }

  Future<List<Descuento>> getDescuentos() async {
    return await descuentos.getPromociones();
  }

  Future<List<Categoria>> getCategories() async {
    List<Categoria> c = [];
    final docs = await firestore
        .collection('Category')
        .get()
        .then((value) => value.docs);
    for (var doc in docs) {
      c.add(Categoria(nombre: doc.id));
    }
    return c;
  }

  Future<Usuario> getInfoUser(String id) async {
    final u = await firestore.collection('Users').doc(id).get();
    return Usuario.fromFirestore(u);
  }

  Future<String> getImage(BuildContext context, String igName) async {
    var x = await FirebaseStorage.instance.ref("Libros").listAll();
    final url = await x.items[0].getDownloadURL();
    return url;
  }

  Future<List<Producto>> getProducts() async {
    List<Producto> p = [];
    final QuerySnapshot result = await firestore.collection('Producto').get();
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

  Future<Producto> get_product(String key) async {
    var doc = await this.firestore.collection('Producto').doc(key).get();
    return (Producto(
        activo: doc['available'],
        nombre: doc.id,
        precio: doc['price'],
        descripcion: doc['description'],
        calificacion: doc['rate'],
        cantidad: doc['quantity'],
        categoria: doc['category'],
        imagen: doc['image']));
  }

  Future<List<Producto>> getProductsByCategory(int index) async {
    String categoria =
        await this.getCategories().then((value) => value[index].nombre);
    List<Producto> p = [];
    final result = await firestore.collection('Producto').get().then((value) =>
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
    final QuerySnapshot result = await firestore.collection('Producto').get();
    final List<DocumentSnapshot> documents = result.docs;
    List<String> rt = [];
    for (var doc in documents) {
      rt.add(doc.id);
    }
    return rt;
  }

  Future<List<Producto>> get_cart(String id) async {
    List<Producto> rt = [];
    var docs = await firestore.collection('Cart').doc(id).get();
    String x = docs['productsID'].toString();
    RegExp regExp = new RegExp("\{(.*)\}");
    var tmp = regExp.allMatches(x).first.group(1).split(",");
    for (var i in tmp) {
      var z = i.split(':');
      Producto p = await this.get_product(z[0].trim());
      p.cantidad = int.parse(z[1].trim());
      rt.add(p);
    }
    return rt;
  }
}
