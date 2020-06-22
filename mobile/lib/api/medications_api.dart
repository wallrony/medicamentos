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

      List<Map<String, dynamic>> mapListResponse = responseToMap(response);

      response = List<Medication>();

      if (mapListResponse.isNotEmpty)
        for (final medication in mapListResponse)
          response.add(Medication.fromJson(medication));
    } catch (error) {
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

  add(token, userId, name, description, value) async {
    if (!(await isOnline())) return 'offline';

    var response,
        body = {
      'name': name,
      'description': description,
      'value': value,
    };

    try {
      response = await http.post(
        '$apiUrl/medications?user_id=$userId',
        body: body,
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

  update(token, id, name, description, value) async {
    if (!(await isOnline())) return 'offline';

    var response,
        body = {
      'name': name,
      'description': description,
      'value': value,
    };

    try {
      response = await http.put(
        "$apiUrl/medicamentos/$id",
        body: body,
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

      if(mapResponse['result'] == 'success') response = true; 
      else throw Exception("");
    } catch (error) {
      response = unexpectedErrorText();
    }

    return response;
  }
}
