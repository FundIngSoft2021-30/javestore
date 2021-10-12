//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarTop extends StatefulWidget implements PreferredSizeWidget {
  final String textoProducto;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  AppBarTop({
    Key key,
    this.textoProducto,
  }) : super(key: key);

  @override
  _AppBarTop createState() => _AppBarTop();
}

class _AppBarTop extends State<AppBarTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      ),
      centerTitle: true,
      title: Text(widget.textoProducto),
      backgroundColor: Colors.blue,
    ));
  }
}
