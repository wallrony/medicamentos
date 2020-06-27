import 'package:usermedications/controller/provider/base_provider.dart';
import 'package:usermedications/model/user.dart';
import 'package:usermedications/utils/utils.dart';

class UserProvider extends BaseProvider {
  User _user;
  User get user => _user;

  fetchUser(String token, int id) async {
    setRunning(true);

    User user = await facade.showUser(token, id);

    user.name = treatName(user.name);

    _user = user;

    setRunning(false);

    notifyListeners();
  }

  Future<bool> setUser(User newUser) async {
    var result = await facade.saveUserPref(newUser);
    
    _user = newUser;

    notifyListeners();

    return result;
  }

  Future<bool> clearUserPrefData() async => await facade.clearUserPrefData();
}
