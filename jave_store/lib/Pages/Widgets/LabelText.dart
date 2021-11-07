import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Widgets/ButtonOption.dart';

class LabelText extends StatefulWidget {
  @override
  _LabelText createState() => _LabelText();
}

class _LabelText extends State<LabelText> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width / 1.8,
        height: size.height / 12,
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
//        initialValue: 'Input text',
          maxLength: 250,
          decoration: InputDecoration(
            labelText: 'Instrucciones adicionales',
            labelStyle: TextStyle(
              color: Colors.blue,
            ),
            suffixIcon: Icon(
              Icons.check_circle,
            ),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
