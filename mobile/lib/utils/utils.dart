import 'dart:convert';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermedications/components/custom_button.dart';
import 'package:usermedications/components/custom_dialog_pop_button.dart';
import 'package:usermedications/components/custom_text.dart';

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
        ),
      );
    },
  );
}

showMessageDialog(BuildContext context, String title, String description,
    List<Map<String, dynamic>> actions) {
  showDialog(
      context: context,
      barrierDismissible: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: title,
                  color: Colors.black,
                  fontSize: 24,
                  isBold: true,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                CustomText(
                  text: description,
                  color: Colors.black87,
                  fontSize: 15,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 30),
                actions == null
                  ? CustomDialogPopButton()
                  : actions.map(
                      (action) =>
                      Container(
                        width: double.maxFinite,
                        child: CustomIconButton(
                          label: action['label'],
                          onPressed: action['onPressed'],
                          reverseColors: action['reverseColors'],
                          icon: action['icon'],
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      )
  );
}

showOfflineDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "Sem Conexão...",
                color: Colors.black,
                fontSize: 24,
                isBold: true,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              CustomText(
                  text: "Vocẽ precisa estar conectado à internet para realizar qualquer operação!",
                  color: Colors.black87,
                  fontSize: 16,
                  textAlign: TextAlign.left
              ),
              SizedBox(height: 30),
              CustomDialogPopButton(),
            ],
          ),
        ),
      ),
    ),
  );
}

makeActionObject(String label,
    bool reverseColors,
    Function onPressed,
    Icon icon,) {
  final action = {
    'label': label,
    'reverseColors': reverseColors,
    'onPressed': onPressed,
    'icon': icon,
  };

  return action;
}

closeDialog(BuildContext context) {
  Navigator.of(context).pop();
}

buildPageWithProvider<T extends ChangeNotifier>(
    {@required T bloc, @required Widget page}) {
  return ChangeNotifierProvider.value(
    value: bloc,
    child: page,
  );
}

treatName(String name) {
  name = name.toLowerCase();
  List<String> splittedName = name.split(' ');

  for (var i = 0; i < splittedName.length; i++) {
    String namePart = splittedName[i];

    namePart = "${namePart[0].toUpperCase()}${namePart.substring(1)}";

    print("NamePart: $namePart");

    splittedName[i] = namePart;
  }

  return splittedName.join(' ');
}
