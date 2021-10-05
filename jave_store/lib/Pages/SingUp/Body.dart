//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _pass = false;
  String passCamp;
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
                      "SING UP",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "First Name",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Enter email",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      onChanged: (val) {
                        passCamp = val;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      onChanged: (val) {
                        if (passCamp == val)
                          this._pass = true;
                        else
                          this._pass = false;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirm your password",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: Icon(this._pass
                            ? Icons.check_outlined
                            : Icons.cancel_outlined),
                      ),
                    ),
                    SizedBox(height: 70),
                    roundedButton(size),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget roundedButton(Size size) {
  return Container(
      width: 250,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.blue,
          child: FlatButton(
            onPressed: () {
              print("Hola");
            },
            child: Text(
              "Create account",
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
