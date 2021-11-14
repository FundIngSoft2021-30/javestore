//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/controller/Cart/cartController.dart';
import 'package:localstorage/localstorage.dart';

class CardProducto extends StatefulWidget {
  final Producto item;
  CardProducto({this.item});
  @override
  _CardProductoState createState() => _CardProductoState(item: this.item);
}

class _CardProductoState extends State<CardProducto> {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  Producto item;
  _CardProductoState({this.item});
  void _update(int value) {
    CartController c = new CartController();
    setState(() {
      item.quantity = value;
      c.update_quantity(item.name, item.quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(item.image), fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Expanded(
                child: Text(
                  item.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  int i = item.quantity;
                  if (i > 0) {
                    i--;
                    _update(i);
                  }
                },
                icon: Icon(Icons.remove_circle),
              ),
              Text('${item.quantity}'),
              IconButton(
                onPressed: () {
                  int i = item.quantity;
                  i++;
                  _update(i);
                },
                icon: Icon(Icons.add_circle),
              ),
              // Text(double.parse(item.precio).toString()),
            ],
          ),
        ],
      ),
    );
  }
}
