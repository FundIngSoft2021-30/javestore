import 'package:flutter/material.dart';


class InfoNombreId extends StatelessWidget {
  @override

  String nombre = 'Carlos Escorche';
  String id='1000334';

  Widget build(BuildContext context) {
    
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            flex:1,
            child:
            
            Padding
            (
            padding: EdgeInsets.all(20),
            child: CircleAvatar(
              backgroundImage: AssetImage('logo.png'),
              radius:70,
            ),
            )
          ),
            
          Expanded(
            flex:2,
            child:
            Column(
              children: <Widget> [
                Text(nombre, style:
                TextStyle(fontSize:25)),
            
                  Text('id. '+id,style:TextStyle(fontSize:18,color:Colors.grey)),
                   
              ]
            )
          )
        ]
      )
    );
      

  }
}

