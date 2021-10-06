import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Catalogo/Background.dart';

class body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<body> {
  bool _pass = false;
  String passCamp = "";
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return Scaffold(
      /*banner de navegacion*/

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(40)),
          child: Center(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  prefixIcon: FloatingActionButton(
                      child: Icon(Icons.search, color: Colors.black),
                      onPressed: () {},
                      backgroundColor: Colors.yellow),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                  hintText: 'Buscar producto...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),

      /* Barra inferior*/

      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.person_outline),
            tooltip: "Ver perfil de usuario",
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
