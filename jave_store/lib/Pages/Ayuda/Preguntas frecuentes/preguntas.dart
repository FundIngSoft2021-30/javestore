//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/controller/apiFB.dart';

class Preguntas extends StatelessWidget {
  final ApiFB api = ApiFB();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text('Pedido'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: FutureBuilder<List<Map<String, String>>>(
            future: api.get_frecuent_question(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Alert(
                                      snapshot.data[index].values.toList()[0]);
                                });
                          },
                          leading: Icon(Icons.question_answer),
                          title: Text(snapshot.data[index].keys.toList()[0]),
                        ));
                      },
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget Alert(String msm) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade50,
      title: Text("Respuesta"),
      content: Text(msm),
    );
  }
}
