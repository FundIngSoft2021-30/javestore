//@dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Pages/Widgets/AppBarBottom.dart';

List<Login> LoginFromJson(String str) =>
    List<Login>.from(json.decode(str).map((x) => Login.fromJson(x)));

class Login {
  String user;
  String pass;

  Login({
    this.user,
    this.pass,
  });
  factory Login.fromJson(Map<String, dynamic> json) => Login(
        user: json["user"],
        pass: json["pass"],
      );
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showPassword = true;
  bool _obscureText = true;
  final url = "http://10.0.2.2/jave/queryDB.php";
  Future checkLogin(String mail, String pass) async {
    print(mail + pass);
    final response = await http.post(Uri.parse(url), body: {
      "query":
          "select email as user,password as user from Cuenta where email=${mail} and password=${pass};"
    });

    try {
      Login l = LoginFromJson(response.body)[0];
      if (l.pass == pass && l.user == mail) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AppBarBottom()),
        );
      }
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String pass, val;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: TextField(
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.black),
              ),
              focusColor: Colors.amber,
              labelText: "Email",
              labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal),
              hintText: "Email",
              hintStyle: TextStyle(
                fontSize: 12,
              ),
            ),
            onChanged: (value) {
              val = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 4),
          child: TextField(
            obscureText: _obscureText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(
                    () {
                      this._showPassword = !this._showPassword;
                      this._obscureText = _showPassword;
                    },
                  );
                },
                child: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.black),
              ),
              focusColor: Colors.amber,
              labelText: "Password",
              labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal),
              hintText: "Password",
              hintStyle: TextStyle(
                fontSize: 12,
              ),
            ),
            onChanged: (value) {
              pass = value;
            },
          ),
        ),
        InkWell(
          child: Text(
            "Forgot password?",
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontSize: 12,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
            print("value of your text");
          },
        ),
        Center(
          child: roundedButton(size, context),
          heightFactor: 4.5,
        ),
      ],
    );
  }
}

Widget roundedButton(Size size, BuildContext context) {
  return Container(
      width: 250,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.blue,
          child: FlatButton(
            onPressed:(){
              
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ) // This
      );
}
