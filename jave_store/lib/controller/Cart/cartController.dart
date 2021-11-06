// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/controller/apiFB.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CartController c = CartController(cartID: 'zDPg5UAyVCbc0qgLQqekBWhUk4N2');
}

class CartController {
  ApiFB _api = ApiFB();
  String cartID;

  CartController({this.cartID});
  //If bool is true then it will increase the quantity of the product else it will decrease the quantity
  Future<void> update_quantity(String id_product, int replaceTO) async {
    var products = await this._api.get_cart(this.cartID);
    if (replaceTO > 0) {
      for (Producto p in products) {
        if (p.name == id_product) {
          p.quantity = replaceTO;
          List<String> names = [for (Producto p in products) p.name];
          List<int> values = [for (Producto p in products) p.quantity];
          Map<String, int> map = Map.fromIterables(names, values);
          this
              ._api
              .firestore
              .collection('Cart')
              .doc(this.cartID)
              .update({'productsID': map});
          break;
        }
      }
    } else {
      remove_product(id_product);
    }
  }

  Future<void> remove_product(String id_product) async {
    var products = await this._api.get_cart(this.cartID);
    List<String> names = [for (Producto p in products) p.name];
    int index = names.indexOf(id_product);
    names.removeAt(index);
    List<int> values = [for (Producto p in products) p.quantity];
    values.removeAt(index);
    Map<String, int> map = Map.fromIterables(names, values);
    print(map.toString());
    this
        ._api
        .firestore
        .collection('Cart')
        .doc(this.cartID)
        .update({'productsID': map});
  }

  Future<void> add_product(Producto product) async {
    var products = await this._api.get_cart(this.cartID);
    List<String> names = [for (Producto p in products) p.name];
    List<int> values = [for (Producto p in products) p.quantity];
    if (names.contains(product.name))
      update_quantity(product.name, product.quantity + 1);
    else {
      names.add(product.name);
      values.add(1);
      Map<String, int> map = Map.fromIterables(names, values);
      this
          ._api
          .firestore
          .collection('Cart')
          .doc(this.cartID)
          .update({'productsID': map});
    }
  }

  Future<String> get_cost() async {
    var products = await this._api.get_cart(this.cartID);
    List<double> values = [for (Producto p in products) p.price * p.quantity];
    double sum = 0;
    for (double p in values) {
      sum += p;
    }
    return await sum.toString();
  }
}
