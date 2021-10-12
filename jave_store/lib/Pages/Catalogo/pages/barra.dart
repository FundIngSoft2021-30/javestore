//@dart=2.9
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color:  Color(0xFFB5BFD0).withOpacity(0.32),
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon:Icon(Icons.search),
          hintText: "Search Here",
          hintStyle: TextStyle(color: Color(0xFFB5BFD0)),
        ),
      ),
    );
  }
}