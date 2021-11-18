//@dart=2.9
// ignore_for_file: deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Usuario.dart';
import 'package:jave_store/controller/apiFB.dart';

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
                      onChanged: (value) async {},
                      decoration: InputDecoration(
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
                            onPressed: () async {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email.text, password: pass.text)
                                  .then(
                                (value) async {
                                  Usuario u = Usuario(
                                    nombre: nombre.text,
                                    numero: int.parse(number.text),
                                  );
                                  if (await ApiFB()
                                      .create_user(value.user.uid, u)) {
                                    ApiFB().create_cart(value.user.uid);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Alert(
                                              'Creado', 'Usuario creado');
                                        });
                                  }
                                },
                              ).catchError(
                                (error) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Alert('Error', error.message);
                                      });
                                },
                              );
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

  Widget Alert(String title, String content) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade50,
      title: Text(title),
      content: Text(content),
    );
  }
}
