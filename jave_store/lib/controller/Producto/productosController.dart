// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jave_store/Entidades/Producto.dart';

class productosController {
  FirebaseFirestore _firestore;

  productosController(FirebaseFirestore firestore) {
    this._firestore = firestore;
  }
  Future<bool> delete_product(String key) async {
    await this
        ._firestore
        .collection('Producto')
        .doc(key)
        .delete()
        .then((value) => print("Producto eliminado"))
        .catchError((error) => print("Fallo eliminacion: $error"));
    return true;
  }

  Future<bool> modify_product(Producto p, String name) async {
    await this
        ._firestore
        .collection('Producto')
        .doc(p.name)
        .update({
          'available': p.available,
          'name': name,
          'image': p.image,
          'description': p.description,
          'price': p.price,
          'category': p.category,
          'rate': p.rate,
          'quantity': p.quantity
        })
        .then((value) => print("Producto modificado"))
        .catchError((error) => print("Fallo modificacion: $error"));
    return true;
  }

  Future<bool> check_name(String key) async {
    bool salida;
    await this
        ._firestore
        .collection('Producto')
        .doc(key)
        .get()
        .then((value) => salida = true)
        .catchError((error) => salida = false);
    return await salida;
  }
}
