//@dart=2.9
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Entidades/Usuario.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _pass = false;
  bool _email = true;
  TextEditingController nombre = new TextEditingController();
  TextEditingController apellido = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController number = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<bool> getData() async {
      final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
      final response = await http.post(Uri.parse(url), body: {
        "query": "select id from Cuenta where email='${email.text}';"
      });
      String c = jsonDecode(response.body).toString();
      if (c.length > 2)
        return true;
      else
        return false;
    }

    Future createAccount() async {
      if (number.text.length == 10) {
        Usuario u = Usuario();
        u.nombre = nombre.text;
        u.apellido = apellido.text;
        u.email = email.text;
        u.pass = pass.text;
        u.rol = "S";
        u.numero = number.text;
        print(u.nombre + u.apellido + u.numero);
        final url = "https://javestore.000webhostapp.com/jave/crearCuenta.php";
        final response = await http.post(Uri.parse(url), body: {
          "name": u.nombre,
          "surname": u.apellido,
          "email": u.email,
          "password": u.pass,
          "rol": u.rol,
          "number": u.numero,
        });
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: size.height / 1.2,
            width: size.width / 1.2,
            color: Colors.transparent,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                child: Column(
                  children: [
                    Text(
                      "Registro",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.black),
                      controller: nombre,
                      decoration: InputDecoration(
                          labelText: "Nombre",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Apellido",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      controller: apellido,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Teléfono",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      controller: number,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) async {
                        bool flag = await getData();
                        if (flag)
                          this._email = false;
                        else
                          this._email = true;
                      },
                      decoration: InputDecoration(
                          suffixIcon: Icon(this._email
                              ? Icons.check_outlined
                              : Icons.cancel_outlined),
                          labelText: "Email",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      controller: email,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      controller: pass,
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        if (pass.text == value)
                          this._pass = true;
                        else
                          this._pass = false;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirmar contraseña",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: Icon(this._pass
                            ? Icons.check_outlined
                            : Icons.cancel_outlined),
                      ),
                    ),
                    SizedBox(height: 70),
                    Container(
                      width: 250,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.blue,
                          child: FlatButton(
                            onLongPress: () => Alert(),
                            onPressed: () {
                              createAccount();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Alert();
                                  });
                            },
                            child: Text(
                              "Crear cuenta",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ), // This
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Alert() {
    return AlertDialog(
      backgroundColor: Colors.blue.shade50,
      title: Text("Cuenta creada"),
      content: Text("La cuenta ha sido creada con éxito"),
    );
  }
}
