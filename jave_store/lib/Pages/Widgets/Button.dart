//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  final String textoBoton;
  final double divWidth;
  final double divHeight;
  Button({Key key, this.textoBoton, this.divHeight, this.divWidth})
      : super(key: key);

  @override
  _Button createState() => new _Button();
}

class _Button extends State<Button> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / widget.divWidth,
      height: size.height / widget.divHeight,
      child: ElevatedButton(
        onPressed: () {
          // Respond to button press
        },
        child: Text(widget.textoBoton),
      ),
    );
  }
}
