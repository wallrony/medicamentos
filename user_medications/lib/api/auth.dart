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

      final mapResponse = Map<String, dynamic>.from(json.decode(utf8.decode(response.bodyBytes)));
      mapResponse['user']['user'] = user;

      userData = User.fromJson(mapResponse['user']);
    }
    catch(error) {
      print(error);
      userData = unexpectedErrorText();
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

      final mapResponse = Map<String, dynamic>.from(json.decode(utf8.decode(response.bodyBytes)));

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