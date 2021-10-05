//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @required
  final Widget child;
  Background({@required this.child});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "images/background.jpg",
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        child,
        Positioned(
          top: size.height / 7,
          right: size.width / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.asset(
              "images/logo.png",
              width: 180,
            ),
          ),
        ),
      ],
    );
  }
}
