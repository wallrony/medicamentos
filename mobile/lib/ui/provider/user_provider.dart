import 'package:usermedications/ui/provider/base_provider.dart';
import 'package:usermedications/core/model/user.dart';
import 'package:usermedications/core/utils/utils.dart';

class UserProvider extends BaseProvider {
  User _user;
  User get user => _user;

  fetchUser(String token, int id) async {
    setRunning(true);

    var data = await facade.showUser(token, id);

    if(data.runtimeType == User) {
      data.name = treatName(data.name);

      _user = data;
    }

    setRunning(false);

    notifyListeners();

    if(data.runtimeType == String) return data;
  }

  Future<bool> setUser(User newUser) async {
    var result = await facade.saveUserPref(newUser);
    
    _user = newUser;

    notifyListeners();

    return result;
  }

  Future<bool> clearUserPrefData() async => await facade.clearUserPrefData();
}
