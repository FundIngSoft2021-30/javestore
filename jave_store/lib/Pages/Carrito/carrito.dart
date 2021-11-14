//@dart=2.9

import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Carrito/cardProducto.dart';
import 'package:jave_store/Pages/Pago/Pago.dart';
import 'package:jave_store/controller/Cart/cartController.dart';
import 'package:jave_store/controller/apiFB.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class Carrito extends StatefulWidget {
  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  final ApiFB api = ApiFB();
  @override
  Widget build(BuildContext context) {
    final cartC = Provider.of<CartController>(context);
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<Producto>>(
        future: api.get_cart(storage.getItem('id')),
        builder: (context, AsyncSnapshot<List<Producto>> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          List<Producto> productosPago = snapshot.data;
          return snapshot.hasData
              ? Stack(
                  children: [
                    ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Dismissible(
                          key: Key(snapshot.data[index].name),
                          onDismissed: (direction) {
                            dismissedItem(context, index, snapshot.data[index]);
                          },
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFFFE6E6),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Spacer(),
                                Icon(Icons.remove_shopping_cart_sharp),
                              ],
                            ),
                          ),
                          child: CardProducto(item: snapshot.data[index]),
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: cartC.get_cost(),
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return snapshot.hasData
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, -2),
                                            blurRadius: 20,
                                            color: Color(0000000)
                                                .withOpacity(0.25)),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 20, top: 20, end: 20),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.shopping_bag,
                                                size: 35,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  text:
                                                      "Total: ${double.parse(snapshot.data).round()}",
                                                ),
                                              ),
                                              Spacer(),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) => pago(
                                                                    productos:
                                                                        productosPago,
                                                                    total: double.parse(
                                                                            snapshot.data)
                                                                        .round()
                                                                        .toString(),
                                                                    carritoId: storage
                                                                        .getItem(
                                                                            'id'),
                                                                  )));
                                                },
                                                child: Container(
                                                  child: Stack(
                                                    children: [
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Text('');
                        }),
                  ],
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  void dismissedItem(BuildContext context, int index, Producto item) async {
    CartController().remove_product(item.name);
  }
}
