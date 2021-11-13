//@dart=2.9
import 'dart:async';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Pedido.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Perfil/Historial/HistorialScreen.dart';
import 'package:jave_store/controller/apiFB.dart';
import 'package:toggle_switch/toggle_switch.dart';

class body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
  String total;
  String descuentos;
  List<Producto> productos;
  String carritoId;

  body({
    this.productos,
    this.total,
    this.carritoId,
  });
}

class _BodyState extends State<body> {
  ApiFB api = ApiFB();

  String medioEntrega = 'A domicilio';
  String instrucciones;

  bool almacenarPedido() {
    Pedido p = new Pedido();
    if (instrucciones != null) if (instrucciones.isNotEmpty) {
      p.carritoId = widget.carritoId;
      p.fecha = DateTime.now();
      p.instrucciones = instrucciones;
      p.metodoEntrega = medioEntrega;
      p.productos =
          List.from(widget.productos.map((name) => name.name).toList());
      p.total = double.parse(widget.total);
      api.add_pedido(p);
      return true;
    } else
      print('intrucciones vacias');
    return false;
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
//
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("El campo instrucciones esta vacío"),
      content: Text("Escriba alguna instrucción para completar la compra"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<String> getDescuento(List<Producto> productos) async {
    return api.descuentos.getDescuentos(widget.productos);
  }

  Future<ListView> listaItems(List<Producto> productos) async {
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

  int _state = 0;
  bool estado = true;

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Confirmar Pedido",
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      );
    } else if (_state == 2) {
      return Icon(Icons.check, color: Colors.blue);
    }
    return Text('s');
  }

  void animateButton() {
    setState(() {
      if (almacenarPedido())
        _state = 1;
      else
        showAlertDialog(context);
    });
    if (_state == 1)
      Timer(Duration(milliseconds: 3300), () {
        setState(() {
          _state = 2;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HistorialScreen()));
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
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
              Center(
                child: ToggleSwitch(
                  minWidth: 125,
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: ['A domicilio', 'Recoger en la U'],
                  onToggle: (index) {
                    print('switched to: $index');
                    if (index == 0)
                      medioEntrega = 'A domicilio';
                    else
                      medioEntrega = 'Recoger en la U';
                  },
                ),
              ),
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
              SizedBox(height: size.height / 100),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FutureBuilder(
                  future: getDescuento(widget.productos),
                  builder: (context, snapshot) {
                    print(snapshot);
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? Text('Descuentos: \$ ' + snapshot.data,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18.0))
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ), /*Text(
                  'Descuentos: \$ ' + getDescuento(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0),
                ),*/
              ),
              SizedBox(height: size.height / 160),
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
              SizedBox(height: size.height / 40),
              Center(
                child: Container(
                  width: size.width / 1.8,
                  height: size.height / 12,
                  child: TextFormField(
                    cursorColor: Theme.of(context).cursorColor,
                    onChanged: (text) {
                      print('texto' + text);
                      instrucciones = text;
                    },
                    maxLength: 250,
                    decoration: InputDecoration(
                      labelText: 'Instrucciones adicionales',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                      ),
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
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
                child: MaterialButton(
                  child: setUpButtonChild(),
                  onPressed: () {
                    setState(() {
                      if (_state == 0) {
                        animateButton();
                      }
                      if (_state == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistorialScreen()),
                        );
                      }
                    });
                  },
                )),
          ),
        ),
      ],
    );
  }
}
