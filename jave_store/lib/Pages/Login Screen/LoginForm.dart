//@dart=2.9
// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/controller/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:jave_store/Pages/SingUp/SingUp.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final LocalStorage storage = new LocalStorage('localstorage_app');
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height / 8,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Form(
              key: globalFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: user,
                    keyboardType: TextInputType.emailAddress,
                    //onSaved: (input) => loginRequestModel.email = input,
                    validator: (input) => !input.contains('@') ? "" : null,
                    decoration: new InputDecoration(
                      hintText: "Correo electrónico",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    controller: pass,
                    style: TextStyle(color: Theme.of(context).accentColor),
                    keyboardType: TextInputType.text,
                    //onSaved: (input) => loginRequestModel.password = input,
                    validator: (input) =>
                        input.length < 3 ? "Debe tener 3 caracteres" : null,
                    obscureText: hidePassword,
                    decoration: new InputDecoration(
                      hintText: "Contraseña",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).accentColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        // ignore: deprecated_member_use
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 15),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                    onPressed: () async {
                      await authService.signIn(user.text, pass.text);
                      if (authService.status == AuthStatus.Authenticated) {
                        storage.setItem('id', authService.currentUser.uid);
                      }
                    },
                    child: Text(
                      "Iniciar sesión",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SingUp()),
                      );
                    },
                    child: Text(
                      "Crear cuenta",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
