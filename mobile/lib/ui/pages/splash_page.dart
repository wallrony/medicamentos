import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usermedications/ui/components/medkit_icon.dart';
import 'package:usermedications/ui/services/user_service.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  redirect() async {
    await Future.delayed(Duration(seconds: 4));
    UserService().initialRedirect(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Center(
          child: Hero(
            tag: 'medkit-logo',
            child: MedkitIcon(iconSize: 96),
          ),
        ),
      ),
    );
  }
}