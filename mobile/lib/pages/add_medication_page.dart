import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:usermedications/animation/FadeAnimation.dart';
import 'package:usermedications/components/custom_form.dart';
import 'package:usermedications/components/custom_text.dart';
import 'package:usermedications/controller/facade.dart';
import 'package:usermedications/controller/provider/medication_provider.dart';
import 'package:usermedications/model/medication.dart';
import 'package:usermedications/services/user_service.dart';
import 'package:usermedications/utils/form_utils.dart';
import 'package:usermedications/utils/nav_utils.dart';
import 'package:usermedications/utils/system_colors.dart';
import 'package:usermedications/utils/utils.dart';

class AddMedicationPage extends StatefulWidget {
  @override
  _AddMedicationPageState createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemColors.addMedicationColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            SystemColors.homeColors();

            NavUtils.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                makeHeader(),
                makeAddMedicationForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget makeHeader() {
    return FadeAnimation(
      1,
      Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: CustomText(
          text: "Cadastrar Medicamento",
          fontSize: 36,
          isBold: true,
        ),
      ),
    );
  }

  Widget makeAddMedicationForm() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: FadeAnimation(
        1.2,
        CustomForm(
          this.formKey,
          FormUtils.makeMedicationFormOptions(getFormControllers()),
          FormUtils.makeSubmitProp(
            submitFunction: _addMedication,
            submitLabel: 'Adicionar',
          ),
        ),
      ),
    );
  }

  List<TextEditingController> getFormControllers() => [
        nameController,
        descriptionController,
        valueController,
      ];

  void _addMedication() async {
    if (formKey.currentState.validate()) {
      showLoadingDialog(context);

      String name = nameController.text;
      String description = descriptionController.text;
      double value = double.parse(valueController.text);

      Medication medication = Medication(0, name, description, value);

      var userData = await _getUserData();

      if (userData == null) return;

      var data = await Facade().addMedication(userData[0], int.parse(userData[1]), medication);

      closeDialog(context);

      if (data.runtimeType == String) {
        if (data == 'offline')
          showOfflineDialog(context);
        else
          showMessageDialog(context, 'Há algo de errado..', data, null);
      } else if (data.runtimeType == bool && data) {
        showMessageDialog(
          context,
          'Sucesso!',
          'Medicamento cadastrado com sucesso!',
          null,
        );

        loadMedications();

        NavUtils.pop(context);
      }
    }
  }

  _getUserData() async {
    List<String> userData = await UserService().getUserPrefs();

    if (userData.isEmpty) {
      return;
    }

    return userData;
  }

  loadMedications() async {
    List<String> userData = await _getUserData();

    if (userData.isEmpty) return;

    await Provider.of<MedicationProvider>(context, listen: false).fetchMedications(
      userData[0],
      int.parse(userData[1]),
    );
  }

  clearFields() {
    nameController.text = '';
    descriptionController.text = '';
    valueController.text = '';
  }
}
