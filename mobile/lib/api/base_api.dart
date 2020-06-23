import 'dart:convert';

abstract class BaseApi {
  final apiUrl = 'http://192.168.0.105:3333';

  getHeaders({token}) {
    final headers = token != null
        ? {
            'content-type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Token $token'
          }
        : {'content-type': 'application/json', 'accept': 'application/json'};

    return headers;
  }

  responseToMap(response) {
    final map =
        Map<String, dynamic>.from(json.decode(utf8.decode(response.bodyBytes)));

    return map;
  }
}