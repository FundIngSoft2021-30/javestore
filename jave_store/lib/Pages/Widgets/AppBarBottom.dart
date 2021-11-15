//@dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Ayuda/screenAyuda.dart';
import 'package:jave_store/Pages/Carrito/carrito.dart';
import 'package:jave_store/Pages/Catalogo/categorias.dart';
import 'package:jave_store/Pages/Perfil/InformacionPerfil.dart';
import 'package:jave_store/Pages/Promociones/Promociones.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppBarBottom());
}

class AppBarBottom extends StatefulWidget {
  @override
  _AppBarBottom createState() => _AppBarBottom();
}

class _AppBarBottom extends State<AppBarBottom> {
  List<bool> _show = [false, true, true, true, false];

  List<String> _bar = ["", "Ofertas", "Carrito de compras", "Perfil", ""];
  List<Widget> _paginas = [
    Categories(),
    promociones(),
    Carrito(),
    InformacionPerfil(),
    screenAyuda()
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
      key: Key('Inicio'),
      home: Scaffold(
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
              label: 'Inicio',
              icon: Icon(
                Icons.home,
              ),
              tooltip: "Volver a Inicio",
            ),
            BottomNavigationBarItem(
              label: 'Ofertas',
              icon: Icon(Icons.account_balance_wallet_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Carrito',
              icon: Icon(Icons.shopping_cart_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Perfil',
              icon: Icon(Icons.person_outline),
            ),
            BottomNavigationBarItem(
              label: 'Ayuda',
              icon: Icon(Icons.help_outline_sharp),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
