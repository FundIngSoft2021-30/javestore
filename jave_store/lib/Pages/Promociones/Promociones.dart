//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Promociones/Body.dart';

void main() => runApp(promociones());

class promociones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      body(),
    ]);
  }
}
