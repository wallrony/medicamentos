import 'package:http/http.dart' as http;
import 'package:usermedications/utils/utils.dart';

class UserApi {
  show(token, id) async {
    if(!(await isOnline())) {
      return 'offline';
    }

    var response;

    try {
      response = await http.get("${apiUrl()}/users/$id", headers: getHeaders(token: token));
      
    }
    catch(error) {
      print(error);
      response = unexpectedErrorText();
    }

    return response;
  }
}