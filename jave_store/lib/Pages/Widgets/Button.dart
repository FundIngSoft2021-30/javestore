//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  final String textoBoton;
  Button({Key key, this.textoBoton}) : super(key: key);

  @override
  _Button createState() => new _Button();
}

class _Button extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Respond to button press
      },
      child: Text(widget.textoBoton),
    );
  }
}
