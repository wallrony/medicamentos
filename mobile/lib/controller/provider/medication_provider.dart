import 'package:usermedications/controller/provider/base_provider.dart';
import 'package:usermedications/model/medication.dart';

class MedicationProvider extends BaseProvider {
  List<Medication> _medications;

  List<Medication> get medications => _medications;

  fetchMedications(String token, int userId) async {
    setRunning(true);

    var medicationList = await facade.indexMedications(token, userId);

    if (medicationList.runtimeType != String)
      _medications = medicationList;
    else
      _medications = [];

    await Future.delayed(Duration(seconds: 3));

    setRunning(false);

    notifyListeners();
  }

  refreshMedications(String token, int userId) async {
    setRunning(true);

    var medicationList = await facade.indexMedications(token, userId);

    if (medicationList.runtimeType != String) {
      medicationList.sort(_sortMedicationById);
    }

    await Future.delayed(Duration(seconds: 3));

    setRunning(false);

    notifyListeners();
  }

  _sortMedicationById(Medication a, Medication b) {
    if(a.id > b.id) {
      return 1;
    }
    else if(a.id < b.id) {
      return -1;
    }

    return 0;
  }

  deleteMedication(String token, int userId, int id) async {
    setRunning(true);

    await facade.delete(token, id);

    await refreshMedications(token, userId);
  }
}
