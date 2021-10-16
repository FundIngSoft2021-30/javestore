//@dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Pages/Login%20Screen/api/ApiService.dart';
import 'package:jave_store/Pages/Login%20Screen/model/login_model.dart';
import 'package:jave_store/Pages/SingUp/SingUp.dart';
import 'package:jave_store/Pages/Widgets/AppBarBottom.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel =
      LoginRequestModel(email: "tomatoe@gmail.com", password: "tomatoe123");
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
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
                keyboardType: TextInputType.emailAddress,
                //onSaved: (input) => loginRequestModel.email = input,
                validator: (input) => !input.contains('@') ? "" : null,
                decoration: new InputDecoration(
                  hintText: "Correo electrónico",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2))),
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
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2))),
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
                    color: Theme.of(context).accentColor.withOpacity(0.4),
                    icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
              SizedBox(height: 30),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppBarBottom()),
                  );
                  if (validateAndSave()) {
                    setState(() {
                      isApiCallProcess = true;
                    });

                    APIService apiService = new APIService();
                    apiService.login(loginRequestModel).then((value) {
                      if (value != null) {
                        setState(() {
                          isApiCallProcess = false;
                        });

                        if (value.token.isNotEmpty) {
                          final snackBar =
                              SnackBar(content: Text("Login Successful"));
                          scaffoldKey.currentState.showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(content: Text("Error"));
                          scaffoldKey.currentState.showSnackBar(snackBar);
                        }
                      }
                    });
                  }
                },
                child: Text(
                  " Login ",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
                shape: StadiumBorder(),
              ),
              // SizedBox(height: 15),
              // FlatButton(
              //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => 
              //       SingUp()),
              //     );
              //   },
              //   child: Text(
              //     "Crear cuenta",
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   color: Theme.of(context).accentColor,
              //   shape: StadiumBorder(),
              // ),
            ],
          ),
        ),
      ),
    ]);
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
