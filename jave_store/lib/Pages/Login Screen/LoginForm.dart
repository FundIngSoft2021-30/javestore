//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Entidades/Cuenta.dart';
import 'package:jave_store/Pages/SingUp/SingUp.dart';
import 'package:jave_store/Pages/Widgets/AppBarBottom.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final url = "https://javestore.000webhostapp.com/jave/cuenta.php";

  Future<Cuenta> getData() async {
    final response = await http.post(Uri.parse(url),
        body: {"email": user.text, "password": pass.text});
    List<Cuenta> c = CuentaFromJson(response.body);
    if (c.length == 0) {
      print("Email isn't in our system");
    } else {
      return c[0];
    }
    return null;
  }

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
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
                controller: user,
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
              SizedBox(height: size.height / 15),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                onPressed: () async {
                  Cuenta c = await getData();
                  if (c.rol == "S") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppBarBottom()),
                    );
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
    ]);
  }
}
