import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:usermedications/api/base_api.dart';
import 'package:usermedications/model/medication.dart';
import 'package:usermedications/utils/utils.dart';

class MedicationApi extends BaseApi {
  index(token, userId) async {
    if (!(await isOnline())) return 'offline';

    var response;

    try {
      response = await http.get(
        "$apiUrl/medicamentos?user_id=$userId",
        headers: getHeaders(token: token),
      );

      List<Map<String, dynamic>> mapListResponse = responseToMap(
        response,
        isList: true,
      );

      response = List<Medication>();

      if (mapListResponse.isNotEmpty)
        for (final medication in mapListResponse)
          response.add(Medication.fromJson(medication));
    } catch (error) {
      print(error);

      response = unexpectedErrorText();
    }

    return response;
  }

  show(token, userId, id) async {
    if (!(await isOnline())) return 'offline';

    var response;

    try {
      response = await http.get(
        "$apiUrl/medicamentos/$id?user_id=$userId",
        headers: getHeaders(token: token),
      );

      Map<String, dynamic> mapResponse = responseToMap(response);

      if (mapResponse.isNotEmpty)
        response = Medication.fromJson(mapResponse);
      else
        throw Exception("");
    } catch (error) {
      response = unexpectedErrorText();
    }

    return response;
  }

  add(token, userId, Medication medication) async {
    if (!(await isOnline())) return 'offline';

    var response, body = medication.toMap(withId: false);

    print(json.encode(body));

    try {
      response = await http.post(
        '$apiUrl/medicamentos?user_id=$userId',
        body: json.encode(body),
        headers: getHeaders(token: token),
      );

      Map<String, dynamic> mapResponse = responseToMap(response);

      print(mapResponse);

      if (mapResponse['result'] == 'success')
        response = true;
      else if (mapResponse['result'] == 'fail') throw Exception("");
    } catch (error) {
      print(error);
      response = unexpectedErrorText();
    }

    return response;
  }

  update(String token, int id, Medication medication) async {
    if (!(await isOnline())) return 'offline';

    var response, body = medication.toMap(withId: true);

    try {
      response = await http.put(
        "$apiUrl/medicamentos/$id",
        body: json.encode(body),
        headers: getHeaders(token: token),
      );

      Map<String, dynamic> mapResponse = responseToMap(response);

      if (mapResponse['result'] == 'success')
        response = true;
      else if (mapResponse['result'] == 'fail') throw Exception("");
    } catch (error) {
      response = unexpectedErrorText();
    }

    return response;
  }

  delete(token, id) async {
    if (!(await isOnline())) return 'offline';

    var response;

    try {
      response = await http.delete(
        "$apiUrl/medicamentos/$id",
        headers: getHeaders(token: token),
      );

      Map<String, dynamic> mapResponse = responseToMap(response);

      if (mapResponse['result'] == 'success')
        response = true;
      else
        throw Exception("");
    } catch (error) {
      response = unexpectedErrorText();
    }

    return response;
  }
}
