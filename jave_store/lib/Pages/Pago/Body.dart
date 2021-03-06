//@dart=2.9
import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Producto> productos;
  String carritoId;
  String temTotal;

  body({
    this.productos,
    this.total,
    this.carritoId,
    this.temTotal,
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
      p.fecha = Timestamp.now();
      p.instrucciones = instrucciones;
      p.metodoEntrega = medioEntrega;
      p.productos =
          List.from(widget.productos.map((name) => name.name).toList());
      p.total = double.parse(widget.temTotal);
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

  Future<ListView> listaItems(List<Producto> productos) async {
    widget.total = await widget.total;
    widget.productos = await widget.productos;
    print(widget.productos.length);
    return ListView.builder(
      key: Key('listaPago'),
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

    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width * 0.9,
            height: size.height * 0.6,
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
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: size.height / 80),
                Center(
                  child: ToggleSwitch(
                    key: Key('toggleEntrega'),
                    minWidth: size.width * 0.4,
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
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text('Resumen',
                      style: TextStyle(fontSize: 15.0),
                      textAlign: TextAlign.left),
                ),
                SizedBox(height: size.height / 60),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey[800], width: 1.0)),
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
                SizedBox(height: size.height / 60),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: FutureBuilder(
                      future: ApiFB().descuentos.getDescuentos(widget
                          .productos), // a previously-obtained Future<String> or null
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          print(snapshot.error);
                        else
                          widget.temTotal = ((double.parse(widget.total) -
                                      double.parse(snapshot.data))
                                  .round())
                              .toString();
                        return snapshot.hasData
                            ? Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Subtotal:        ",
                                      style: TextStyle(
                                        fontSize: size.width * 0.035,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ), //Textstyle
                                    ),
                                    Text(
                                      "${widget.total} ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: size.width * 0.035,
                                          color: Colors.green,
                                          fontWeight:
                                              FontWeight.w300), //Textstyle
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Descuento:     ",
                                      style: TextStyle(
                                        fontSize: size.width * 0.035,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ), //Textstyle
                                    ),
                                    Text(
                                      "- ${double.parse(snapshot.data).round()}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: size.width * 0.035,
                                          color: Colors.red,
                                          fontWeight:
                                              FontWeight.w300), //Textstyle
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total:        ",
                                      style: TextStyle(
                                        fontSize: size.width * 0.035,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ), //Textstyle
                                    ),
                                    Text(
                                      "\$${(double.parse(widget.total) - double.parse(snapshot.data)).round()}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: size.width * 0.035,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ), //Textstyle
                                    ),
                                  ],
                                )
                              ])
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total: ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ), //Textstyle
                                  ),
                                  Text(
                                    '\$' + "${widget.total} ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ), //Textstyle
                                  ),
                                ],
                              );
                      }),
                ),
                SizedBox(height: size.height / 30),
                Center(
                  child: Container(
                    width: size.width / 1.5,
                    height: size.height / 8,
                    child: TextFormField(
                      key: Key('instrucciones'),
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
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.1,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.blue[700]),
                      child: Center(
                        child: Icon(
                          Icons.credit_card,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
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
                  width: size.width / 1.5,
                  height: size.height / 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.blue[700], width: 2.6),
                      color: Colors.white),
                  child: MaterialButton(
                    key: Key('confirmarPedido'),
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
      ),
    );
  }
}
