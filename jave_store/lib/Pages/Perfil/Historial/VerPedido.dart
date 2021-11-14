//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Pedido.dart';
import 'package:jave_store/controller/Cart/cartController.dart';
import 'package:jave_store/controller/Pedido/pedidoController.dart';
import 'package:jave_store/controller/apiFB.dart';
import 'package:intl/intl.dart';

class VerPedido extends StatelessWidget {
  List<String> productos;
  ApiFB ap = new ApiFB();
  VerPedido({this.productos});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("herrera mrk"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: productos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image(
                image: NetworkImage(
                    ('https://depor.com/resizer/IqLYwICHcmvlXT8-S7L888u81R8=/980x0/smart/filters:format(jpeg):quality(75)/arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/JHRUKSIYBZBQNIDBNTCDQPP6JQ.jpg')),
              ),
              title: Text('${productos[index]}'),
            );
          },
        ),
      ),
    );
  }
}
