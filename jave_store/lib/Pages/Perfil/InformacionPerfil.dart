//@dart=2.9
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Usuario.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Pages/Perfil/Info.dart';

class InformacionPerfil extends StatelessWidget {
  final url = "http://10.0.2.2/jave/queryDB.php";
  Future<Usuario> getData() async {
    final response = await http.post(Uri.parse(url),
        body: {"query": "select * from Usuario where id=2;"});

    Usuario rt = UsuarioFromJson(response.body)[0];
    return rt;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: size.width / 4.6,
              backgroundImage: NetworkImage(
                  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.UvWpsuNa0vidHjqXG7Lp1QHaLH%26pid%3DApi&f=1"),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          FutureBuilder<Usuario>(
              future: getData(),
              builder: (context, AsyncSnapshot<Usuario> snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? Column(
                        children: [
                        
                          Info(name: "Nombre", numero: snapshot.data.nombre),
                          Info(name: "Apellido", numero: snapshot.data.apellido),
                          Info(
                            numero: snapshot.data.numero,
                            name: "Número Telefónico",
                          ),
                          SizedBox(height:size.height/4,),
                          BotonHistorialCompras(size, context),
                        ],
                      )
                    : new Center(
                        child: new CircularProgressIndicator(),
                      );
              }),
        ],
      ),
    );
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Catalogo()),
              // );
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
