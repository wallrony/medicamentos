import 'package:usermedications/api/auth_api.dart';
import 'package:usermedications/api/medications_api.dart';
import 'package:usermedications/api/user_api.dart';
import 'package:usermedications/controller/preferences/pref.dart';
import 'package:usermedications/model/user.dart';

class Facade {
  AuthApi _authApi;
  UserApi _userApi;
  MedicationApi _medApi;
  Prefs _prefs;

  static final Facade _instance = Facade._internal();

  factory Facade() => _instance;

  Facade._internal() {
    _authApi = AuthApi();
    _userApi = UserApi();
    _medApi = MedicationApi();
    _prefs = Prefs();
  }

  /// AUTH API OPERATIONS
  login(String user, String pswd) async => await _authApi.login(user, pswd);

  register(
    String name,
    String user,
    String pswd,
  ) async =>
      await _authApi.register(name, user, pswd);

  /// USER API OPERATIONS
  showUser(String token, int id) async => await _userApi.show(token, id);

  updateUser(
    String token,
    int id,
    String name,
    String user,
    String pswd,
  ) async =>
      await _userApi.update(token, id, name, user, pswd);

  deleteUser(
    String token,
    int id,
  ) async =>
      await _userApi.delete(token, id);

  /// MEDICATIONS API OPERATIONS
  indexMedications(
    String token,
    int userId,
  ) async =>
      await _medApi.index(token, userId);

  showMedication(
    String token,
    int userId,
    int id,
  ) async =>
      await _medApi.show(token, userId, id);

  addMedication(
    String token,
    int userId,
    medication,
  ) async =>
      await _medApi.add(token, userId, medication);

  updateMedication(
    String token,
    int id,
    String name,
    String description,
    double value,
  ) async =>
      await _medApi.update(token, id, name, description, value);

  delete(String token, int id) async => await _medApi.delete(token, id);

  /// SHARED PREFERENCES OPERATIONS
  saveUserPref(User user) async => await _prefs.saveUserPref(user);

  getUserPref() async => await _prefs.getUserPref();

  userIsLogged() async => await _prefs.userIsLogged();

  clearUserPrefData() async => await _prefs.clearUserPref();
}
