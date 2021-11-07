//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
      child: ToggleSwitch(
        minWidth: 125,
        initialLabelIndex: 0,
        totalSwitches: 2,
        labels: ['A domicilio', 'Recoger en la U'],
        onToggle: (index) {
          print('switched to: $index');
        },
      ),
    );
  }
}
