//@dart=2.9
// ignore_for_file: deprecated_member_use

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Usuario.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jave_store/Pages/Perfil/Historial/HistorialScreen.dart';
import 'package:jave_store/Pages/Perfil/Info.dart';
import 'package:jave_store/Pages/Perfil/avatar.dart';
import 'package:jave_store/controller/apiFB.dart';
import 'package:jave_store/controller/services/auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class InformacionPerfil extends StatelessWidget {
  final ApiFB api = new ApiFB();
  final LocalStorage storage = new LocalStorage('localstorage_app');

  @override
  Widget build(BuildContext context) {
    print('${storage.getItem('id')}');
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Avatar(
              onTap: () async {
                var state = await Permission.photos.request();
                print(state.isDenied);
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          FutureBuilder<Usuario>(
              future: api.getInfoUser(storage.getItem('id')),
              builder: (context, AsyncSnapshot<Usuario> snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? Column(
                        children: [
                          Info(name: "Nombre", numero: snapshot.data.nombre),
                          Info(
                            numero: "${snapshot.data.numero}",
                            name: "Número",
                          ),
                          SizedBox(
                            height: size.height / 14,
                          ),
                          Container(
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
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HistorialScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Historial de compras",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 60,
                          ),
                          Container(
                            width: 250,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.blue,
                                child: FlatButton(
                                  onPressed: () {
                                    context.read<AuthService>().signOut();
                                  },
                                  child: Text(
                                    "Cerrar sesión",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
