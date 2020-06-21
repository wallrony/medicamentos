import 'package:usermedications/api/auth.dart';

class Facade {
  AuthApi authApi;

  static final Facade _instance = Facade._internal();

  factory Facade() => _instance;

  Facade._internal() {
    authApi = AuthApi();
  }

  login(String user, String pswd) async => await authApi.login(user, pswd);

  register(String name, String user, String pswd) async =>
      await authApi.register(
        name,
        user,
        pswd,
      );
}
