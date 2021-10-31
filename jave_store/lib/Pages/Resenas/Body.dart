import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

class body extends StatefulWidget {
  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<body> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Raul',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Buen producto'
    },
    {
      'name': 'Joaquin',
      'pic': 'https://picsum.photos/300/30',
      'message': 'cumplió todas mis expectativas'
    },
    {
      'name': 'Saul',
      'pic': 'https://picsum.photos/300/30',
      'message': 'buen produto'
    },
    {
      'name': 'Pablo',
      'pic': 'https://picsum.photos/300/30',
      'message': 'regular'
    },
  ];

  Widget commentChild(data) {
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
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
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
        child: commentChild(filedata),
        labelText: 'Escriba una reseña...',
        withBorder: false,
        errorText: 'Commentario no puede estar en blanco',
        sendButtonMethod: () {
          if (formKey.currentState!.validate()) {
            print(commentController.text);
            setState(() {
              var value = {
                'name': 'Juan',
                'pic':
                    'https://unsplash.com/photos/MTZTGvDsHFY/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjM1NjU3MjE2&force=true&w=640',
                'message': commentController.text
              };
              filedata.insert(0, value);
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
