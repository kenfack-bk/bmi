import 'package:bmi/screens/home.dart';
import 'package:bmi/services/share_prefs.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharePrefs.init();
  runApp(BimApp());
}

class BimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC CALCULATOR',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(title: 'IMC CALCULATOR'),
    );
  }
}
