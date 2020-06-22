import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usermedications/animation/FadeAnimation.dart';
import 'package:usermedications/components/custom_form_button.dart';
import 'package:usermedications/components/custom_form_field.dart';
import 'package:usermedications/components/custom_text.dart';
import 'package:usermedications/components/grey_line.dart';
import 'package:usermedications/components/medkit_icon.dart';
import 'package:usermedications/controller/facade.dart';
import 'package:usermedications/model/user.dart';
import 'package:usermedications/pages/register_page.dart';
import 'package:usermedications/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController userController = TextEditingController();
  final TextEditingController pswdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              top: 80,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                makeHeader(),
                makeLoginForm(),
                makeFooter(),
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
          FadeAnimation(1, MedkitIcon(iconSize: 96)),
          SizedBox(height: 40),
          FadeAnimation(
              1.2,
              CustomText(
                text: "Login",
                fontSize: 54,
                isBold: true,
              )),
          FadeAnimation(
            1.4,
            CustomText(
              text: "Entre e usufrua de nossos serviços!",
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget makeLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                  1.6,
                  makeInput(
                    label: "Nome de Usuário",
                    controller: userController,
                    validateFun: validateUser,
                  ),
                ),
                FadeAnimation(
                  1.8,
                  makeInput(
                    label: "Senha",
                    obscureText: true,
                    controller: pswdController,
                    validateFun: validatePswd,
                  ),
                ),
                FadeAnimation(1.8, GreyLine()),
                FadeAnimation(
                  2,
                  FormButton(
                    label: "Entrar",
                    onTap: login,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void login() async {
    if (formKey.currentState.validate()) {
      showLoadingDialog(context);

      String user = userController.text;
      String pswd = pswdController.text;

      var result = await Facade().login(user, pswd);

      closeDialog(context);

      if (result.runtimeType == String) {
        if (result == 'offline') {
          showOfflineDialog(context);
        } else {
          showMessageDialog(context, "Há algo de errado...", result, [
            makeActionObject(
              'Ok',
              true,
              () => closeDialog(context),
              Icon(Icons.close),
            ),
          ]);
        }
      } else {
        showMessageDialog(context, "Sucesso!", 'Login feito com sucesso!', [
          makeActionObject(
            'Ok',
            true,
            () => closeDialog(context),
            Icon(Icons.close),
          ),
        ]);
        // redirect to homepage with changenotifier user provider
      }
    }
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

  Widget makeFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: FadeAnimation(
        2.2,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Não tem uma conta ainda? ",
              color: Colors.grey[500],
              fontSize: 13,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: CustomText(
                text: "Cadastre-se!",
                color: Colors.grey[500],
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
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
}
