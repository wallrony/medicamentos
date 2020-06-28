import 'package:shared_preferences/shared_preferences.dart';
import 'package:usermedications/core/model/user.dart';

class Prefs {
  static final Prefs _instance = Prefs._internal();

  factory Prefs() => _instance;

  Prefs._internal();

  Map<String, String> _prefKeys = {
    "userId": "@USER_MED:USER_IDENTIFICATION",
    "userToken": "@USER_MED:USER_TOKEN",
  };

  Map<String, String> get prefKeys => _prefKeys;

  Future<SharedPreferences> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  Future<bool> saveUserPref(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool result;

    try {
      result = await prefs.setInt(
        Prefs().prefKeys['userId'],
        user.id,
      );

      if(result) {
        result = await prefs.setString(
          Prefs().prefKeys['userToken'],
          user.token,
        );

        if(!result) throw Exception('saveDataError');
      }
      else throw Exception('saveDataError');
    }
    catch(error) {
      result = false;
    }

    return result;
  }

  Future<bool> userIsLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool result;

    try {
      result = prefs.containsKey(prefKeys['userId']);
    }
    catch(error) {
      result = false;
    }

    return result;
  }

  Future<bool> clearUserPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool result;

    try {
      result = await prefs.remove(prefKeys['userId']);

      if(result) {
        result = await prefs.remove(prefKeys['userToken']);

        if(!result) throw Exception('clearDataError');
      }
      else throw Exception('clearDataError');
    }
    catch(error) {
      result = false;
    }

    return result;
  }

  Future<List<String>> getUserPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString(prefKeys['userToken']);
    int userId = prefs.getInt(prefKeys['userId']);

    return [token, userId.toString()];
  }
}