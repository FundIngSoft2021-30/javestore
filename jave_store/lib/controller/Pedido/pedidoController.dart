// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jave_store/Entidades/Pedido.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/controller/Cart/cartController.dart';
import 'package:intl/intl.dart';
import 'package:jave_store/controller/apiFB.dart';

class pedidoController {
  FirebaseFirestore _firestore;

  pedidoController(FirebaseFirestore firestore) {
    this._firestore = firestore;
  }

  Future<bool> insertPedido(Pedido pedido) async {
    await _firestore
        .collection('Pedido')
        .add({
          'carritoId': pedido.carritoId,
          'fecha': pedido.fecha,
          'instrucciones': pedido.instrucciones,
          'metodoEntrega': pedido.metodoEntrega,
          'productos': pedido.productos,
          'total': pedido.total
        })
        .then((value) => print("Pedido agregado"))
        .catchError((error) => print("Fallo inserción: $error"));

    CartController carrito = new CartController();
    await carrito.clear_cart();
    return true;
  }

  Future<List<Pedido>> get_pedido(String id) async {
    var docs =
        await _firestore.collection('Pedido').get().then((value) => value.docs);

    List<Pedido> p = [];
    for (var doc in docs) {
      Pedido temp = Pedido.fromJson(doc.data());
      if (temp.carritoId == id) {
        p.add(temp);
      }
    }

    return p;
  }

  Future<List<Pedido>> get_pedido_byDate(String date) async {
    var docs =
        await _firestore.collection('Pedido').get().then((value) => value.docs);

    List<Pedido> p = [];
    for (var doc in docs) {
      Pedido temp = Pedido.fromJson(doc.data());
      DateTime d = temp.fecha.toDate();

      if (DateFormat('yyyy-MM-dd').format(d) == date) {
        p.add(temp);
      }
    }
    return p;
  }

  Future<List<Producto>> getAllPbydate(String date) async {
    Set s = new Set<String>();
    List<Pedido> v = await get_pedido_byDate(date);
    for (Pedido i in v) {
      for (String j in i.productos) {
        s.add(j);
      }
    }
    List<Producto> p = [];
    print(s);
    for (String i in s) {
      Producto temp = await ApiFB().get_product(i);
      p.add(temp);
    }
    return p;
  }

  Future<double> cost_by_date(String date) async {
    var p = await get_pedido_byDate(date);
    double cost = 0;
    for (var i in p) {
      cost += i.total;
    }
    return cost;
  }
}
