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
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(passwordField);
    await tester.enterText(passwordField, "test123");
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(signInButton);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(
        find.byWidgetPredicate(
            (widget) => widget is MaterialApp && widget.key == Key('Inicio')),
        findsOneWidget);
  });
}
