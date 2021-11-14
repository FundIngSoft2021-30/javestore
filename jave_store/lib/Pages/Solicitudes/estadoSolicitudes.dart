import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              child: new Text('Estado Solicitudes',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 25)),
            ),
            backgroundColor: Color(0xFF004aac),
          ),
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                        child: Image(
                            image: AssetImage('images/page2.png'),
                            height: 210,
                            width: 233,
                            alignment: Alignment.center)),
                    SizedBox(height: 14),
                    Text("Nombre producto",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Container(
                      height: size.height * 0.1,
                      color: Colors.grey[200],
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ingrese nombre del producto'),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "Descripcion",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Container(
                      color: Colors.grey[200],
                      height: size.height * 0.1,
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ingrese descripcion del producto '),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: size.width * 0.8,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: InkWell(
                          child: Text(
                            "Guardar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Alert("It's working"),
                            );
                          }),
                    ),
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
