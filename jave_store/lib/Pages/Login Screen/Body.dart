//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Login%20Screen/Background.dart';
import 'package:jave_store/Pages/Login%20Screen/LoginForm.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.blue.shade300,
      child: Background(
        child: Positioned(
          bottom: 0,
          left: 1,
          right: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: cardLogin(
                  size,
                  LoginForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardLogin(Size size, Widget content) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Container(
      padding: EdgeInsets.all(20),
      height: size.height / 1.5,
      width: size.width / 1.2,
      color: Colors.transparent,
      child: content,
    ),
  );
}
