//@dart=2.9
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Catalogo/ventanaProducto.dart';
import 'package:jave_store/controller/apiFB.dart';

class ItemCard extends StatelessWidget {
  final Producto product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => ventanaProducto(product: product));
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 160,
                width: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Hero(
                  tag: product.name,
                  child: Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20 / 4),
                child: Text(
                  // products is out demo list
                  product.name,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              FutureBuilder<String>(
                  future: ApiFB().descuentos.getDescuentosProducto(
                      product), // a previously-obtained Future<String> or null
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? Column(children: [
                            Row(children: [
                              Text(
                                  "\$${(product.price - double.parse(snapshot.data)).round()}  ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent[700])),
                              Text("\$${product.price}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12)),
                            ])
                          ])
                        : Text("\$${product.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent[700]));
                  }),
            ]));
  }
}
