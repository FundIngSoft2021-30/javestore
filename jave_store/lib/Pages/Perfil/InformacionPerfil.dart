import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Perfil/Titulo.dart';
import 'package:jave_store/Pages/Perfil/InfoNombreId.dart';
import 'package:jave_store/Pages/Perfil/InfoCelular.dart';
import 'package:jave_store/Pages/Perfil/InfoDireccion.dart';
import 'package:jave_store/Pages/Catalogo/Catalogo.dart';

class InformacionPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: <Widget>[
        Titulo(),
        InfoNombreId(),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: InfoCelular(),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: InfoDireccion(),
        ),
        Center(
          child: BotonHistorialCompras(size, context),
          heightFactor: 4.5,
        )
      ],
    ));
  }
}

Widget BotonHistorialCompras(Size size, BuildContext context) {
  return Container(
      width: 250,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.blue,
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => catalogo()),
              );
            },
            child: Text(
              "Historial Compras",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ) // This
      );
}
