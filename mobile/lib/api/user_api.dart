import 'package:http/http.dart' as http;
import 'package:usermedications/api/base_api.dart';
import 'package:usermedications/model/user.dart';
import 'package:usermedications/utils/utils.dart';

class UserApi extends BaseApi {
  show(token, id) async {
    if (!(await isOnline())) return 'offline';

    var response;

    try {
      response = await http.get("$apiUrl/users/$id",
          headers: getHeaders(token: token));

      final Map<String, dynamic> mapResponse = responseToMap(response);

      if (mapResponse.isEmpty) {
        throw Exception("Não existe nenhum usuário com o id passado!");
      }

      response = User.fromJson(mapResponse);
    } catch (error) {
      if (error.toString().contains("nenhum usuário"))
        response = error;
      else
        response = unexpectedErrorText();
    }

    return response;
  }

  add(name, user, pswd) async {
    if (!(await isOnline())) return 'offline';

    var response, body = {'name': name, 'user': user, 'pswd': pswd};

    try {
      response = await http.post(
        '$apiUrl/users',
        body: body,
        headers: getHeaders(),
      );

      final Map<String, dynamic> mapResponse = responseToMap(response);

      if (mapResponse['result'] == 'fail')
        throw Exception(mapResponse['message']);
      else
        response = true;
    } catch (error) {
      print(error);

      if (error.toString().contains("Exception"))
        response = error;
      else
        response = unexpectedErrorText();
    }

    return response;
  }

  update(token, id, name, user, pswd) async {
    if (!(await isOnline())) return 'offline';

    var response, body = {'name': name, 'user': user, 'pswd': pswd};

    try {
      response = await http.put(
        '$apiUrl/users/$id',
        body: body,
        headers: getHeaders(token: token),
      );

      final Map<String, dynamic> mapResponse = responseToMap(response);

      if (mapResponse['result'] == 'fail')
        throw Exception(mapResponse['message']);
      else
        response = true;
    } catch (error) {
      print(error);

      if (error.toString().contains("Exception"))
        response = error;
      else
        response = unexpectedErrorText();
    }

    return response;
  }

  delete(token, id) async {
    if (!(await isOnline())) return 'offline';

    var response;

    try {
      response = await http.delete(
        '$apiUrl/users/$id',
        headers: getHeaders(),
      );

      final Map<String ,dynamic> mapResponse = responseToMap(response);

      if(mapResponse['result'] == 'fail') throw Exception(mapResponse['message']);
      else response = true;
    } catch (error) {
      print(error);
      response = unexpectedErrorText();
    }

    return response;
  }
}
