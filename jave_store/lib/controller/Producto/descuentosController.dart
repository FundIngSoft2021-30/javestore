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
    String resultado;
    //print(productos.length);
    for (var product in productos) {
      String temp = await getDescuentosProducto(product);

      if (temp != null) {
        suma = suma + double.parse(temp).round() * product.quantity;
        resultado = suma.toString();
      }
    }

    return resultado;
  }

  Future<String> getDescuentosProducto(Producto p) async {
    double suma = 0;
    String resultado;

    List<Descuento> descuentos = await getPromociones();

    descuentos.forEach((descuento) {
      if (descuento.productos.contains(p.name)) if (suma <
          descuento.porcentaje * p.price) {
        suma = descuento.porcentaje * p.price;
        resultado = suma.toString();
      }
    });

    return resultado;
  }
}
