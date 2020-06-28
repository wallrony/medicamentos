import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermedications/core/controller/facade.dart';
import 'package:usermedications/ui/provider/medication_provider.dart';
import 'package:usermedications/ui/provider/user_provider.dart';
import 'package:usermedications/ui/pages/dashboard_page.dart';
import 'package:usermedications/ui/pages/login_page.dart';
import 'package:usermedications/core/utils/nav_utils.dart';

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
        child: DashboardPage(),
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
