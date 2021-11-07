//@dart=2.9
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Perfil/Historial/HistorialScreen.dart';
import 'package:jave_store/Pages/Widgets/ButtonLoad.dart';
import 'package:jave_store/Pages/Widgets/ButtonOption.dart';
import 'package:jave_store/Pages/Widgets/LabelText.dart';
import 'package:jave_store/Pages/Widgets/Button.dart';

class body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
  String total;
  List<Producto> productos;

  body({this.productos, this.total});
}

class _BodyState extends State<body> {
  String passCamp = "";
  var _controller = TextEditingController();

  Future<ListView> listaItems(List<Producto> productos) async {
    widget.total = await widget.total;
    widget.productos = await widget.productos;
    print(widget.productos.length);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productos.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 35.0,
        ),
        title: Text(
          productos[index].name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
        subtitle: Text(
          'Cantidad: ' + productos[index].quantity.toString(),
          style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 12.0),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            '\$' + productos[index].price.toString(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return
        /*
        Center(
          child: Material(
            elevation: 30.0,
            color: Colors.white12,
            borderRadius: BorderRadius.circular(18.0),
            child: Container(
              width: 320.0,
              height: 90.0 * 3,
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(18.0)),
            ),
          ),
        ),
        */
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 330.0,
          height: 140.0 * 3,
          decoration: BoxDecoration(
              color: Color.fromRGBO(235, 235, 235, 1),
              borderRadius: BorderRadius.circular(18.0)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 10.0,
                  height: 50.0 / 3.5,
                ),
              ),
              Text('Medio de Entrega',
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: size.height / 80),
              ButtonOption(),
              SizedBox(height: size.height / 40),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text('Resumen',
                    style: TextStyle(fontSize: 15.0),
                    textAlign: TextAlign.left),
              ),
              SizedBox(height: size.height / 60),
              Container(
                width: 300.0,
                height: 82.0 * 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey[800], width: 2.0)),
                child: ListView(children: [
                  FutureBuilder(
                    future: listaItems(widget.productos),
                    builder: (context, snapshot) {
                      print(snapshot);
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? Column(children: [snapshot.data])
                          : new Center(
                              child: new CircularProgressIndicator(),
                            );
                    },
                  ),
                ]),
              ),
              SizedBox(height: size.height / 40),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Total: \$ ' + widget.total,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
              SizedBox(height: size.height / 20),
              LabelText(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Colors.blue[700]),
                    child: Center(
                      child: Icon(
                        Icons.credit_card,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                  Text(
                    'PayU',
                    style: TextStyle(color: Colors.blue[700], fontSize: 12.0),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: InkWell(
            splashColor: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistorialScreen()),
              );
            },
            child: Container(
                width: 270.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.blue[700], width: 2.6),
                    color: Colors.white),
                child: ButtonLoad()),
          ),
        ),
      ],
    );
  }
}
