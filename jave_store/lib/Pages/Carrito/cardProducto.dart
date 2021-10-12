//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Carrito/carrito.dart';

class CardProducto extends StatefulWidget {
  final ProductoxCarrito item;
  CardProducto({this.item});
  @override
  _CardProductoState createState() => _CardProductoState(item: this.item);
}

class _CardProductoState extends State<CardProducto> {
  ProductoxCarrito item;
  _CardProductoState({this.item});
  void _update(String value) {
    setState(() {
      item.cantidad = value;
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
                      image: NetworkImage(item.imagen), fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Expanded(
                child: Text(
                  item.nombre,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  int i = int.parse(item.cantidad);
                  if (i > 0) {
                    i--;
                    _update(i.toString());
                  }
                },
                icon: Icon(Icons.remove_circle),
              ),
              Text(item.cantidad),
              IconButton(
                onPressed: () {
                  int i = int.parse(item.cantidad);
                  i++;
                  _update(i.toString());
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
