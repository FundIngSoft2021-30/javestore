//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// The application under test.
import 'package:jave_store/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("CP07-Prueba Iniciar Sesión", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 1));

    //login screen-CP07-Prueba Iniciar Sesión

    final emailField = find.byKey(Key('email'));
    final passwordField = find.byKey(Key('password'));
    final signInButton = find.byKey(Key('Start'));
    await tester.tap(emailField);
    await tester.enterText(emailField, "test@gmail.com");
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(passwordField);
    await tester.enterText(passwordField, "test123");
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(signInButton);
    await tester.pumpAndSettle(const Duration(seconds: 1));

/*
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MaterialApp && widget.key == Key('Inicio')),
        findsOneWidget);
*/
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final Categoria_Aseo = find.byKey(Key('Aseo'));
    final Categoria_Libros = find.byKey(Key('Libros'));
    final Categoria_Moda = find.byKey(Key('Moda'));
    final Categoria_Utiles = find.byKey(Key('Utiles'));
/*
    final Button_Home =
        find.widgetWithIcon(BottomNavigationBarItem, Icons.home);
    final Button_Ofertas = find.widgetWithIcon(
        BottomNavigationBarItem, Icons.account_balance_wallet_outlined);
    final Button_Carrito = find.widgetWithIcon(
        BottomNavigationBarItem, Icons.shopping_cart_outlined);
    final Button_Perfil =
        find.widgetWithIcon(BottomNavigationBarItem, Icons.person_outline);
    final Button_Ayuda =
        find.widgetWithIcon(BottomNavigationBarItem, Icons.help_outline_sharp);
*/

    final Button_Home = find.byKey(Key('Inicio-bottom'));
    final Button_Ofertas = find.byKey(Key('Ofertas-bottom'));
    final Button_Carrito = find.byKey(Key('Carrito-bottom'));
    final Button_Perfil = find.byKey(Key('Perfil-bottom'));
    final Button_Ayuda = find.byKey(Key('Ayuda-bottom'));

    await tester.tap(Categoria_Utiles);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final Product_Item = find.byKey(Key('Agenda Dogs'));
    await tester.tap(Product_Item);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final Dialog_productoDetallado = find.byKey(Key('productoDetallado'));

    await tester.tap(Dialog_productoDetallado);
    await tester.pumpAndSettle(const Duration(seconds: 1));
/*
    await tester.tap(Button_Home);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(Button_Ofertas);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(Button_Carrito);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(Button_Perfil);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(Button_Ayuda);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    */
/*
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Container && widget.key == Key('Moda')),
        findsOneWidget);
        */
/*
    await tester.tap(Categoria_Libros);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Container && widget.key == Key('Libros')),
        findsOneWidget);


    await tester.tap(Categoria_Aseo);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Container && widget.key == Key('Aseo')),
        findsOneWidget);

    await tester.tap(Categoria_Moda);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Container && widget.key == Key('Moda')),
        findsOneWidget);

    await tester.tap(Categoria_Utiles);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Container && widget.key == Key('Utiles')),
        findsOneWidget);
        */
  });
}
