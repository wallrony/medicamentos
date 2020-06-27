import 'package:flutter/material.dart';
import 'package:usermedications/pages/login_page.dart';
import 'package:usermedications/pages/splash_page.dart';
import 'package:usermedications/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicamentos do Usuário',
      theme: ThemeData(
        appBarTheme: getAppBarTheme(),
        cursorColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashPage(),
    );
  }
}
