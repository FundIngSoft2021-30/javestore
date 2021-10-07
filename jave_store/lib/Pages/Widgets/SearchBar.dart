//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return Container(
      child: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(40)),
          child: Center(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  prefixIcon: FloatingActionButton(
                      child: Icon(Icons.search, color: Colors.black),
                      onPressed: () {},
                      backgroundColor: Colors.yellow),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                  hintText: 'Buscar producto...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }
}
