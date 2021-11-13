import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Administrar Productos',
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: new Center(
              child: new Text('Administrar Productos',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
            ),
            backgroundColor: Color(0xFF004aac),
          ),
          body: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(children: <Widget>[
                new Center(
                    child: Image(
                        image: AssetImage('images/page2.png'),
                        height: 210,
                        width: 233,
                        alignment: Alignment.center)),
                SizedBox(height: 14),
                Text("Nombre producto",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Stack(
                  children: [
                    Container(
                      width: 306,
                      height: 43,
                      color: Color(0xFFe4e4e4),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: ' ingrese nombre del producto'),
                          )),
                    )
                  ],
                ),
                Text("Descripcion",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Stack(
                  children: [
                    Container(
                      width: 306,
                      height: 85,
                      color: Color(0xFFe4e4e4),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'ingrese descripcion del producto '),
                          )),
                    )
                  ],
                ),
                SizedBox(height: 22),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)),
                    child: Text('Enviar solicitud',
                        style: TextStyle(fontSize: 40, color: Colors.white)),
                    height: 59,
                    minWidth: 312,
                    color: Color(0xFF38b6ff),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('please funciona'),
                        ),
                      );
                    })
              ])),
        ));
  }
}
