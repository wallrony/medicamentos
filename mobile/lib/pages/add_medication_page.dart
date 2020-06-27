import 'package:flutter/material.dart';
import 'package:usermedications/animation/FadeAnimation.dart';
import 'package:usermedications/components/custom_form.dart';
import 'package:usermedications/components/custom_text.dart';
import 'package:usermedications/utils/nav_utils.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: () => NavUtils.pop(context),
            child: Icon(Icons.arrow_back_ios, color: Colors.black)
        ),
      ),
      body: Container(
        color: Colors.red,
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
    return FadeAnimation(1,
      Container(
        child: CustomText(
          text: "Cadastrar Medicamento",
          fontSize: 36,
          isBold: true,
        ),
      ),
    );
  }

  Widget makeAddMedicationForm() {
    return FadeAnimation(
      1.2,
      CustomForm(
        this.formKey,

      ),
    );
  }
}
