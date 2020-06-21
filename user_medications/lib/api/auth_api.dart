import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:usermedications/model/user.dart';
import 'package:usermedications/utils/utils.dart';

// Classe responsável por fazer conexão aos métodos de autenticação da api
class AuthApi {
  login(String user, String pswd) async {
    if(!(await isOnline())) {
      return "offline";
    }

    var response, userData;

    try {
      response = await http.post('${apiUrl()}/login', body: json.encode({
        'user': user,
        'pswd': pswd
      }), headers: getHeaders());

      final mapResponse = responseToMap(response);

      if(mapResponse['message'] == 'fail') {
        throw Exception("O nome de usuário ou senha estão incorretos!");
      }

      mapResponse['user']['user'] = user;

      userData = User.fromJson(mapResponse['user']);
    }
    catch(error) {
      print(error);

      if(error.toString().contains("usuário ou senha")) {
        userData = error;
      }
      else {
        userData = unexpectedErrorText();
      }
    }

    return userData;
  }

  register(String name, String user, String pswd) async {
    if(!(await isOnline())) {
      return "offline";
    }

    var response, body = {
      'name': name,
      'user': user,
      'pswd': pswd
    };

    try {
      response = await http.post("${apiUrl()}/users", body: body,
        headers: getHeaders()
      );

      final mapResponse = responseToMap(response);

      if(mapResponse['result'] == 'success') {
        response = true;
      }
    }
    catch(error) {
      response = unexpectedErrorText();
    }

    return response;
  }
}