import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:usermedications/api/base_api.dart';
import 'package:usermedications/model/user.dart';
import 'package:usermedications/utils/utils.dart';

// Classe responsável por fazer conexão aos métodos de autenticação da api
class AuthApi extends BaseApi {
  login(String username, String pswd) async {
    if(!(await isOnline())) {
      return "offline";
    }

    var response, data;

    try {
      response = await http.post('$apiUrl/login', body: json.encode({
        'user': username,
        'pswd': pswd
      }), headers: getHeaders());

      final mapResponse = responseToMap(response);

      if(mapResponse['result'] == 'fail') {
        throw Exception("incorrectCredentials");
      }

      mapResponse['user']['user'] = username;
      mapResponse['user']['name'] = treatName(mapResponse['user']['name']);

      data = User.fromJson(mapResponse['user']);
    }
    catch(error) {
      if(error.message == 'incorrectCredentials')
        data = 'O nome de usuário ou senha estão incorretos!';
      else
        data = unexpectedErrorText();
    }

    return data;
  }

  register(String name, String user, String pswd) async {
    if(!(await isOnline())) return "offline";

    var response, body = {
      'name': name,
      'user': user,
      'pswd': pswd
    }, mapResponse;

    try {
      response = await http.post("$apiUrl/users", body: json.encode(body),
        headers: getHeaders()
      );

      mapResponse = responseToMap(response);

      if(mapResponse['result'] == 'success') response = true;
      else if (mapResponse['result'] == 'fail')
        response = throw Exception("customError");
    }
    catch(error) {
      if(error.message.toString() == "customError")
        response = mapResponse['message'];
      else
        response = unexpectedErrorText();
    }

    return response;
  }
}