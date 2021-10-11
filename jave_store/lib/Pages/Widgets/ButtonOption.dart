//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonOption extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  _ButtonOption createState() => _ButtonOption();
}

class _ButtonOption extends State<ButtonOption> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Material(
          color: Colors.transparent,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  static final Map<String, String> metodoMap = {
    'U': 'Recoger en la U',
    'domicilio': 'A domicilio',
  };

  String _selectedGender = metodoMap.keys.first;
  void onGenderSelected(String metodo) {
    setState(() {
      _selectedGender = metodo;
    });
  }
}
