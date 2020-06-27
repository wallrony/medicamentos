import 'package:usermedications/controller/provider/base_provider.dart';
import 'package:usermedications/model/medication.dart';

class MedicationProvider extends BaseProvider {
  List<Medication> _medications;
  List<Medication> get medications => _medications;

  fetchMedications(String token, int userId) async {
    setRunning(true);

    var medicationList = await facade.indexMedications(token, userId);

    print(medicationList);

    if(medicationList.runtimeType != String)
      _medications = medicationList;
    else
      _medications = [];

    await Future.delayed(Duration(seconds: 3));

    setRunning(false);

    notifyListeners();
  }
}