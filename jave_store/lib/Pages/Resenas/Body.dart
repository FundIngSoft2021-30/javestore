import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Entidades/Resena.dart';
import 'package:jave_store/controller/apiFB.dart';

class body extends StatefulWidget {
  final String Idproduct;

  const body({
    Key? key,
    required this.Idproduct,
  }) : super(key: key);

  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<body> {
  ApiFB api = ApiFB();

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  late List<Resena> filedata = [];

  Future<List<Resena>> getComentarios() async {
    filedata = await api.getresenas(widget.Idproduct);
    return filedata;
  }

  Future<Widget> commentChild(List<Resena> data) async {
    data = await getComentarios();
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comentario selecctionado");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(data.elementAt(i).avatarImagen)),
                ),
              ),
              title: Text(
                data.elementAt(i).nombre,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data.elementAt(i).comentario),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommentBox(
        userImage:
            "https://unsplash.com/photos/MTZTGvDsHFY/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjM1NjU3MjE2&force=true&w=640",
        child: FutureBuilder<Widget>(
          future: commentChild(filedata),
          builder: (context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? Container(child: snapshot.data)
                : new Center();
          },
        ),
        labelText: 'Escriba una reseña...',
        withBorder: false,
        errorText: 'Comentario no puede estar en blanco',
        sendButtonMethod: () {
          if (formKey.currentState!.validate()) {
            print(commentController.text);
            setState(() {
              Resena res = new Resena(
                  avatarImagen:
                      'https://unsplash.com/photos/MTZTGvDsHFY/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjM1NjU3MjE2&force=true&w=640',
                  comentario: commentController.text,
                  idProducto: widget.Idproduct,
                  nombre: 'Juan');
              api.insertarResena(res);
              filedata.add(res);
            });
            commentController.clear();
            FocusScope.of(context).unfocus();
          } else {
            print("No validado");
          }
        },
        formKey: formKey,
        commentController: commentController,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
      ),
    );
  }
}
