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

  responseToMap(response, { bool isList = false }) {
    final jsonObject = json.decode(utf8.decode(response.bodyBytes));

    var map;

    if(isList) {
      if(jsonObject.isEmpty) return List<Map<String, dynamic>>();

      map = List<Map<String, dynamic>>();

      for(var medication in jsonObject) {
        map.add(Map<String, dynamic>.from(medication));
      }
    }
    else {
      map = Map<String, dynamic>.from(jsonObject);
    }

    return map;
  }
}
