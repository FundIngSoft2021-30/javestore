//@dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Login%20Screen/Login.dart';
import 'package:jave_store/Pages/Widgets/AppBarBottom.dart';
import 'package:jave_store/Pages/Administrador/screenAdmin.dart';
import 'package:jave_store/controller/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(FirebaseAuth.instance),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer(builder: (context, AuthService auth, _) {
          switch (auth.status) {
            case AuthStatus.Unauthenticated:
              return LoginScreen();
            case AuthStatus.Authenticated:
              try {
                RegExp regex = RegExp(r'[a-z]*@javeriana.edu.co');
                String email = regex.firstMatch(auth.currentUser.toString())[0];
                if (email.split('@')[0] == 'admin')
                  return ScreenAdmin();
                else
                  return AppBarBottom();
              } catch (e) {
                return AppBarBottom();
              }
              break;
            default:
              return LoginScreen();
              break;
          }
        }),
      ),
    );
  }
}
