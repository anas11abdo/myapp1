import 'package:flutter/material.dart';
import 'package:myapp/screens/nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var name = preferences.getString('name');
  var office = preferences.getString('office');
  var pk = preferences.getString('pk');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: name == null || pk == null || office == null
        ? const LoginPage()
        : nav(username: name, pk: pk, useroffice: office),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'تطبيق معاملات',
      theme: ThemeData(),
      home: const LoginPage(),
    );
  }
}
