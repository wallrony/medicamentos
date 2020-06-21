import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

getAppBarTheme() {
  return AppBarTheme(
    brightness: Brightness.light,
    elevation: 0,
    color: Colors.transparent,
  );
}

isOnline() async {
  ConnectivityResult result = await Connectivity().checkConnectivity();

  return result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi;
}

apiUrl() {
  return 'http://192.168.0.105:3333';
}

getHeaders({token}) {
  final headers = token ? {
    'content-type': 'application/json',
    'accept': 'application/json',
    'Authorization': 'Token $token'
  } : {
    'content-type': 'application/json',
    'accept': 'application/json'
  };

  return headers;
}

unexpectedErrorText() {
  return 'Aconteceu algum erro inesperado. Por favor, tente novamente mais tarde.';
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Color.fromRGBO(50, 205, 100, .6),
          shape: CircleBorder(),
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        )
      );
    },
  );
}

closeDialog(BuildContext context) {
  Navigator.of(context).pop();
}
