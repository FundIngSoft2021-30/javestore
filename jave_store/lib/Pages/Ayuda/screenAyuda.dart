//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Ayuda/Preguntas%20frecuentes/preguntas.dart';
import 'package:url_launcher/url_launcher.dart';

class screenAyuda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey.shade200,
      child: ListView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            heightFactor: size.height * 0.01 / 2,
            child: Text(
              "¿Necesitas ayuda?",
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
          ),
          cardWidget(
              context,
              size,
              'Linea de atención',
              'images/lineadeatencion.png',
              "Requieres ayuda específica,\ncontacta a un administrador\nde ventas.",
              true),
          cardWidget(
              context,
              size,
              'Preguntas frecuentes',
              'images/question.png',
              "Mira aqui las preguntas mas\nencuentra toda la\ninformación que necesites.",
              false),
        ],
      ),
    );
  }

  Widget cardWidget(BuildContext context, Size size, String tittle,
      String route, String description, bool flag) {
    return Card(
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          0.5),
      child: InkWell(
        onTap: flag
            ? () async {
                var whatsapp = "+919144040888";
                var whatsappURl_android =
                    "whatsapp://send?phone=" + whatsapp + "&text=hello";
                if (await canLaunch(whatsappURl_android)) {
                  await launch(whatsappURl_android);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: new Text("whatsapp no installed")));
                }
              }
            : () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Preguntas()));
              },
        child: Container(
          height: size.height * 0.2,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                tittle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Image.asset(route, height: size.height * 0.08),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Text(
                    description,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
