import 'package:flutter/material.dart';
import 'package:usermedications/ui/components/custom_form_button.dart';
import 'package:usermedications/ui/components/custom_form_field.dart';
import 'package:usermedications/ui/components/grey_line.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Map<String, dynamic>> formFields;
  final Map<String, dynamic> submitProp;

  CustomForm(this.formKey, this.formFields, this.submitProp);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(50, 205, 100, .6),
            blurRadius: 20,
            offset: Offset(2, 10),
          )
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            for (Map<String, dynamic> field in formFields)
              CustomFormField(
                label: field['label'],
                controller: field['core.controller'],
                validateFun: field['validateFunction'],
                withBorder: field['label'] != formFields.last['label'],
                obscureText: field['type'] == 'pswd',
                type: field['type'],
              ),
            GreyLine(),
            FormButton(
              label: submitProp['submitLabel'],
              onTap: submitProp['submitFunction'],
            ),
          ],
        ),
      ),
    );
  }
}
