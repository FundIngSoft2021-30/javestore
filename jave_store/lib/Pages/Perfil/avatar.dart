//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String avartarUrl;
  final Function onTap;
  Avatar({this.avartarUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: avartarUrl == null
            ? CircleAvatar(
                radius: 80,
                child: Icon(Icons.photo_camera),
              )
            : CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(avartarUrl),
              ),
      ),
    );
  }
}
