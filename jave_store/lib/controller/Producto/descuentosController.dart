// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jave_store/Entidades/Descuento.dart';
import 'package:jave_store/Entidades/Producto.dart';

class descuentosController {
  FirebaseFirestore _firestore;

  descuentosController(FirebaseFirestore firestore) {
    this._firestore = firestore;
  }
  Future<List<Descuento>> getPromociones() async {
    List<Descuento> c = [];
    final QuerySnapshot result = await _firestore.collection('Descuento').get();
    final List<DocumentSnapshot> docs = result.docs;

    for (var doc in docs) {
      c.add(Descuento(
          fechaFinal: doc["fechaFinal"],
          fechaInicio: doc["fechaInicio"],
          imagenPromocion: doc["imagenPromocion"],
          porcentaje: doc["porcentaje"],
          productos: doc["productos"]));
    }
    return c;
  }

  Future<List<String>> getImagenesDescuentos() async {
    List<String> c = [];
    final QuerySnapshot result = await _firestore.collection('Descuento').get();
    final List<DocumentSnapshot> docs = result.docs;

    for (var doc in docs) {
      c.add(doc["imagenPromocion"]);
    }

    return c;
  }

  Future<String> getDescuentos(List<Producto> productos) async {
    double suma = 0;
    List<Descuento> descuentos = await getPromociones();
    productos.forEach((producto) => descuentos.forEach((descuento) {
          if (descuento.productos.contains(producto))
            suma += (descuento.porcentaje * producto.price) * producto.quantity;
        }));
    return suma.toString();
  }
}
