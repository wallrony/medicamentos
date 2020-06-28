import 'package:flutter/material.dart';

class FormUtils {
  static final _loginLabels = ['Nome de Usuário', 'Senha',];

  static final _loginFieldTypes = [
    'text',
    'pswd',
  ];

  static final _registerLabels = [
    'Nome Completo',
    'Nome de Usuário',
    'Senha',
    'Confirmação de Senha',
  ];

  static final _registerFieldTypes = [
    'text',
    'text',
    'pswd',
    'pswd',
  ];

  static final _medicationLabels = [
    'Nome do Medicamento',
    'Descrição',
    'Valor',
  ];

  static final _medicationFieldTypes = [
    'text', 'text', 'number',
  ];

  static Map<String, dynamic> makeSubmitProp(
      {Function submitFunction, String submitLabel}) {
    Map<String, dynamic> submitProp = {
      'submitFunction': submitFunction,
      'submitLabel': submitLabel
    };

    return submitProp;
  }

  static makeLoginFormOptions(List<TextEditingController> controllers) =>
      _getFormOptions(
        _loginLabels,
        controllers,
        loginValidators(),
        _loginFieldTypes,
      );

  static makeRegisterFormOptions(List<TextEditingController> controllers,
      validators,) =>
      _getFormOptions(
        _registerLabels,
        controllers,
        validators,
        _registerFieldTypes,
      );

  static makeMedicationFormOptions(List<TextEditingController> controllers) =>
      _getFormOptions(_medicationLabels, controllers, medicationValidators(),
        _medicationFieldTypes);

  static _getFormOptions(List<String> fields,
      List<TextEditingController> controllers,
      List<Function> validateFunctions,
      List<String> fieldTypes,) {
    List<Map<String, dynamic>> formFields = new List();

    for (var i = 0; i < fields.length; i++) {
      formFields.add(Map<String, dynamic>.from({
        'label': fields[i],
        'core.controller': controllers[i],
        'validateFunction': validateFunctions[i],
        'type': fieldTypes[i]
      }));
    }

    return formFields;
  }

  /// FORM VALIDATORS

  /// A function to get all login validator functions.
  static List<Function> loginValidators() {
    List<Function> validators = [
      validateUser,
      validatePswd,
    ];

    return validators;
  }

  /// A function to get all register validator functions.
  static List<Function> registerValidators() {
    List<Function> validators = [
      validateName,
      validateUser,
      validatePswd,
      validateConfirmPswd
    ];

    return validators;
  }

  static List<Function> medicationValidators() => [
    validateMedicationName,
    validateMedicationDescription,
    validateMedicationValue
  ];

  /// A function to validate an user username.
  static String validateUser(String text) {
    String result;

    if (text.isEmpty) {
      result = 'Você precisa inserir seu usuário!';
    }

    return result;
  }

  /// A function to validate a password.
  static String validatePswd(String text) {
    String result;

    if (text.isEmpty) {
      result = 'Você precisa inserir sua senha!';
    } else if (text.length < 6) {
      result = 'Senha inválida!';
    }

    return result;
  }

  /// A function to validate a name.
  static String validateName(String text) {
    String result;

    if (text.isEmpty) {
      result = 'Você precisa inserir o seu nome!';
    }

    return result;
  }

  /// A function to validate the confirmation of a password.
  static String validateConfirmPswd(String text, String pswd) {
    String result;

    print("Text: $text");
    print("Pswd: $pswd");

    if (text.isEmpty) {
      result = 'Vocẽ precisa inserir sua senha novamente!';
    } else if (text != pswd) {
      result = 'O que foi digitado não coincide com a sua senha...';
    }

    return result;
  }

  static String validateMedicationName(String text) {
    String result;

    if(text.isEmpty) {
      result = 'Insira o nome do medicamento!';
    }
    else if(text.length < 4) {
      result = 'O nome deve conter no mínimo 4 letras!';
    }

    return result;
  }

  static String validateMedicationDescription(String text) => null;

  static String validateMedicationValue(String text) {
    String result;

    try {
      double value = double.parse(text);

      if(value < 0) {
        result = 'Insira um valor positivo!';
      }
    }
    on FormatException catch(error) {
      result = 'Insira apenas números!';
    }

    return result;
  }
}
