import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        title: 'Estado Solicitudes',
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: new Center(
              child: new Text('Estado Solicitudes',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 25)),
            ),
            backgroundColor: Color(0xFF004aac),
          ),
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                       Image(
                            image: AssetImage('images/page2.png'),
                            height: 80,
                            width: 80,
                            alignment: Alignment.bottomLeft),
                    SizedBox(height: 14),
                    Text("Nombre producto........ Mochila",
                    textAlign: TextAlign.left, 
                        style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)
                            ),
                    Text('Codigo producto......... 0013',
                    textAlign: TextAlign.left, 
                        style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)
                            ),
                    SizedBox(height: size.height * 0.01),
                    Text("Estado",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.beenhere),
                    SizedBox(height: size.height * 0.05),
                  
                  ])),
        ));
  }

  Widget Alert(String msm) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade50,
      title: Text("Respuesta"),
      content: Text(msm),
    );
  }
}
