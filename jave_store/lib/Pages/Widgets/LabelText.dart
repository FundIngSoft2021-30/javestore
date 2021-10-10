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
    return Center(
      child: Container(
        width: 220,
        height: 150,
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
//        initialValue: 'Input text',
          maxLength: 250,
          decoration: InputDecoration(
            labelText: 'Label text',
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
