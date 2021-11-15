//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/controller/apiFB.dart';

class VerPedido extends StatelessWidget {
  final List<String> productos;
  final String date;
  final double cost;
  final ApiFB ap = new ApiFB();
  VerPedido({this.productos, this.cost, this.date});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        width: size.width * 0.8,
        height: size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Pedido",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: size.height * 0.6,
              width: size.width * 0.8,
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder<Producto>(
                    future: ap.get_product(productos[index]),
                    builder: (context, p) {
                      if (p.hasData) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(p.data.image),
                          ),
                          title: Text(productos[index]),
                          subtitle: Text(p.data.price.toString()),
                        );
                      } else {
                        return ListTile(
                          title: Text(productos[index]),
                          subtitle: Text("Cargando..."),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text('  Total: ${this.cost}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
