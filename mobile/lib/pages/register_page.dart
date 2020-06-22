import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usermedications/animation/FadeAnimation.dart';
import 'package:usermedications/components/custom_form_button.dart';
import 'package:usermedications/components/custom_form_field.dart';
import 'package:usermedications/components/custom_text.dart';
import 'package:usermedications/components/grey_line.dart';
import 'package:usermedications/controller/facade.dart';
import 'package:usermedications/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final userController = TextEditingController();
  final nameController = TextEditingController();
  final pswdController = TextEditingController();
  final confirmPswdController = TextEditingController();
  AppBar appBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));

    appBar = AppBar(
      backgroundColor: Colors.transparent,
      leading: FadeAnimation(
          0.6,
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios, color: Colors.black),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height:
              MediaQuery.of(context).size.height - appBar.preferredSize.height,
          width: double.infinity,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                makeHeader(),
                SizedBox(height: 25),
                makeLoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimation(
              1,
              CustomText(
                text: "Cadastre-se",
                fontSize: 42,
                isBold: true,
              )),
          FadeAnimation(
              1.2,
              CustomText(
                text: "E possa cadastrar sua lista de medicamentos pessoal!",
                fontSize: 13,
                color: Colors.grey[500],
              )),
        ],
      ),
    );
  }

  Widget makeLoginForm() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
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
              FadeAnimation(
                  1.4,
                  makeInput(
                    label: "Nome Completo",
                    controller: nameController,
                    validateFun: validateName,
                  )),
              FadeAnimation(
                  1.6,
                  makeInput(
                    label: "Nome de Usuário",
                    controller: userController,
                    validateFun: validateUser,
                  )),
              FadeAnimation(
                  1.8,
                  makeInput(
                    label: "Senha",
                    obscureText: true,
                    controller: pswdController,
                    validateFun: validatePswd,
                  )),
              FadeAnimation(
                  2,
                  makeInput(
                    label: "Confirmação de Senha",
                    obscureText: true,
                    controller: confirmPswdController,
                    validateFun: validateConfirmPswd,
                  )),
              FadeAnimation(2, GreyLine()),
              FadeAnimation(
                  2.2,
                  FormButton(
                    label: 'Criar Conta',
                    onTap: register,
                  )),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget makeInput({
    label,
    obscureText = false,
    validateFun,
    withBorder = true,
    controller,
  }) {
    return CustomFormField(
      label: label,
      obscureText: obscureText,
      validateFun: validateFun,
      withBorder: withBorder,
      controller: controller,
    );
  }

  register() async {
    if (formKey.currentState.validate()) {
      String name = nameController.text;
      String user = userController.text;
      String pswd = pswdController.text;

      showLoadingDialog(context);

      final result = await Facade().register(name, user, pswd);

      closeDialog(context);

      if (result.runtimeType == String) {
        if (result == 'offline')
          showOfflineDialog(context);
        else
          showMessageDialog(
            context,
            'Há algo de errado...',
            result,
            [
              makeActionObject(
                'Ok',
                true,
                () => closeDialog(context),
                Icon(Icons.close),
              ),
            ],
          );
      } else if (result.runtimeType == bool && result == true) 
        showMessageDialog(
          context,
          'Sucesso!',
          'Sua conta foi criada com sucesso! Agora você pode entrar e armazenar os seus medicamentos!',
          [
            makeActionObject(
              'Ok',
              true,
              () {
                clearFields();
                closeDialog(context);
              },
              Icon(Icons.close),
            ),
          ],
        );
    }
  }

  clearFields() {
    nameController.text = '';
    userController.text = '';
    pswdController.text = '';
    confirmPswdController.text = '';
  }

  String validateUser(String text) {
    String result;

    if (text.isEmpty) {
      result = 'Você precisa inserir seu usuário!';
    }

    return result;
  }

  String validatePswd(String text) {
    String result;

    if (text.isEmpty) {
      result = 'Você precisa inserir sua senha!';
    } else if (text.length < 6) {
      result = 'Senha inválida!';
    }

    return result;
  }

  String validateConfirmPswd(String text) {
    String result;

    if (text.isEmpty) {
      result = 'Vocẽ precisa inserir sua senha novamente!';
    } else if (text != pswdController.text) {
      result = 'O que foi digitado não coincide com a sua senha...';
    }

    return result;
  }

  String validateName(String text) {
    String result;

    if (text.isEmpty) {
      result = 'Você precisa inserir o seu nome!';
    }

    return result;
  }
}
