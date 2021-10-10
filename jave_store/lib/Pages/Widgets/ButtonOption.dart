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
    final isSelected = <bool>[false, false];
    return Center(
        child: Container(
      child: ToggleButtons(
        color: Colors.black.withOpacity(0.60),
        selectedColor: Colors.blue,
        selectedBorderColor: Colors.blueAccent,
        fillColor: Colors.blueAccent.withOpacity(0.08),
        splashColor: Colors.blueAccent.withOpacity(0.12),
        hoverColor: Colors.blueAccent.withOpacity(0.04),
        borderRadius: BorderRadius.circular(4.0),
        constraints: BoxConstraints(minHeight: 36.0),
        isSelected: isSelected,
        onPressed: (index) {
          // Respond to button selection
          setState(() {
            isSelected[index] = !isSelected[index];
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Recoger en la U'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('A domicilio'),
          ),
        ],
      ),
    ));
  }
}
