//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Perfil/InformacionPerfil.dart';

class AppBarBottom extends StatefulWidget {
  @override
  _AppBarBottom createState() => _AppBarBottom();
}

class _AppBarBottom extends State<AppBarBottom> {
  @override
  Widget build(BuildContext context) {
    var _currentIndex = 0;
    return Container(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.yellow,
        selectedItemColor: Color(0xFF442B2D),
        unselectedItemColor: Color(0xFF442B2D).withOpacity(.60),
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Inicio'),
            icon: FloatingActionButton(
              child: Icon(Icons.home_sharp),
              onPressed: () {},
              tooltip: "Volver a Inicio",
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Ofertas'),
            icon: Icon(Icons.account_balance_wallet_outlined),
            tooltip: "Mirar los descuentos",
          ),
          BottomNavigationBarItem(
            title: Text('Carrito'),
            icon: Icon(Icons.shopping_cart_outlined),
            tooltip: "Ver carrito de compras",
          ),
          BottomNavigationBarItem(
            title: Text('Perfil'),
            icon: FloatingActionButton(
              child: Icon(Icons.person_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InformacionPerfil()),
                );
              },
              tooltip: "Ver perfil de usuario",
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Ayuda'),
            icon: Icon(Icons.help_outline_sharp),
            tooltip: "Servicio al cliente",
          ),
        ],
      ),
    );
  }
}
