import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermedications/controller/facade.dart';
import 'package:usermedications/controller/provider/medication_provider.dart';
import 'package:usermedications/controller/provider/user_provider.dart';
import 'package:usermedications/pages/home_page.dart';
import 'package:usermedications/pages/login_page.dart';
import 'package:usermedications/utils/nav_utils.dart';

class UserService {
  static final UserService _service = UserService._internal();

  factory UserService() => _service;

  Facade _facade;

  UserService._internal() {
    _facade = Facade();
  }

  initialRedirect(BuildContext context) async {
    bool result = await _facade.userIsLogged();

    Widget page;

    if (result) {
      page = MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => MedicationProvider(),
          )
        ],
        child: HomePage(),
      );
    } else {
      page = LoginPage();
    }

    NavUtils.push(context: context, page: page, replace: true);
  }

  Future<List<String>> getUserPrefs() async {
    List<String> userPrefData = await _facade.getUserPref();

    for (var i = 0; i < userPrefData.length; i++) {
      if (userPrefData[i] == null) userPrefData.removeAt(i);
    }

    return userPrefData;
  }
}
