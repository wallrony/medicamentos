import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermedications/ui/pages/splash_page.dart';
import 'package:usermedications/core/utils/utils.dart';
import 'package:usermedications/ui/provider/medication_provider.dart';
import 'package:usermedications/ui/provider/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MedicationProvider(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
