//@dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Administrador/Reportes/report.dart';
import 'package:jave_store/Pages/Administrador/add_product.dart';
import 'package:jave_store/Pages/Perfil/InformacionPerfil.dart';

import 'ModificarProducto/editar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScreenAdmin());
}

class ScreenAdmin extends StatefulWidget {
  @override
  _ScreenAdmin createState() => _ScreenAdmin();
}

class _ScreenAdmin extends State<ScreenAdmin> {
  List<bool> _show = [false, false, false, true];
  List<String> _bar = [
    "",
    "",
    "Reportes",
    'Perfil',
  ];
  List<Widget> _paginas = [
    editar(),
    AddProduct(),
    Reportes(),
    InformacionPerfil()
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _show[_selectedIndex]
            ? AppBar(title: Center(child: Text(_bar[_selectedIndex])))
            : null,
        body: _paginas[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.yellow,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Color(0xFF442B2D).withOpacity(.50),
          items: [
            BottomNavigationBarItem(
              label: 'Editar',
              icon: Icon(
                Icons.edit,
              ),
              tooltip: "Volver a Inicio",
            ),
            BottomNavigationBarItem(
              label: 'Add',
              icon: Icon(Icons.add_circle),
            ),
            BottomNavigationBarItem(
              label: 'Reportes',
              icon: Icon(Icons.report),
            ),
            BottomNavigationBarItem(
              label: 'Perfil',
              icon: Icon(Icons.account_circle),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
