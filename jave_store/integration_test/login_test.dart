//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// The application under test.
import 'package:jave_store/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("test prueba login verify login", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 5));
    //login screen
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
    await tester.pumpAndSettle(const Duration(seconds: 3));

    final Categoria_Aseo = find.byKey(Key('Aseo'));
    final Categoria_Libros = find.byKey(Key('Libros'));
    final Categoria_Moda = find.byKey(Key('Moda'));
    final Categoria_Utiles = find.byKey(Key('Utiles'));

    final Button_Home = find.byKey(Key('Inicio-bottom'));
    final Button_Ofertas = find.byKey(Key('Ofertas-bottom'));
    final Button_Carrito = find.byKey(Key('Carrito-bottom'));
    final Button_Perfil = find.byKey(Key('Perfil-bottom'));
    final Button_Ayuda = find.byKey(Key('Ayuda-bottom'));

    await tester.tap(Categoria_Utiles);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    final Product_Item = find.byKey(Key('Agenda Dogs'));
    await tester.tap(Product_Item);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final Dialog_productoDetallado = find.byKey(Key('productoDetallado'));
    await tester.tap(Dialog_productoDetallado);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final verResenas_button = find.byKey(Key('verResenas'));
    await tester.tap(verResenas_button);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    final arrow_back_resena = find.byKey(Key('back_resena'));
    await tester.tap(arrow_back_resena);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final Add_Product_button = find.byKey(Key('agregarProducto'));
    await tester.tap(Add_Product_button);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(Button_Carrito);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    final irPago_button = find.byKey(Key('irPago'));
    await tester.tap(irPago_button);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    await tester.tap(find.byKey(Key('toggleEntrega')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
/*
    await tester.drag(find.byKey(Key('listaPago')), const Offset(500.0, 0.0));
    await tester.pumpAndSettle(const Duration(seconds: 2));
*/
    await tester.tap(find.byKey(Key('instrucciones')));
    await tester.enterText(find.byKey(Key('instrucciones')),
        "Paso en 20 minutos a recoger el pedido");
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.byKey(Key('confirmarPedido')));
    await tester.pumpAndSettle(const Duration(seconds: 4));

    await tester.tap(Button_Carrito);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    //Card(key total

    await tester.tap(Button_Home);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(
        find.byWidgetPredicate(
            (widget) => widget is MaterialApp && widget.key == Key('Inicio')),
        findsOneWidget);
  });
}
