import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usermedications/ui/animation/FadeAnimation.dart';
import 'package:usermedications/ui/components/custom_form.dart';
import 'package:usermedications/ui/components/custom_text.dart';
import 'package:usermedications/core/controller/facade.dart';
import 'package:usermedications/core/utils/form_utils.dart';
import 'package:usermedications/core/utils/utils.dart';

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
        body: Container(
          height:
              MediaQuery.of(context).size.height - appBar.preferredSize.height,
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  makeHeader(),
                  SizedBox(height: 25),
                  makeLoginForm(),
                ],
              ),
            ],
          ),
        ));
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
            ),
          ),
          FadeAnimation(
            1.2,
            CustomText(
              text: "E possa cadastrar sua lista de medicamentos pessoal!",
              fontSize: 13,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget makeLoginForm() {
    return FadeAnimation(
      1.4,
      CustomForm(
        this.formKey,
        FormUtils.makeRegisterFormOptions(
          getRegisterFormControllers(),
          getRegisterFormValidators(),
        ),
        FormUtils.makeSubmitProp(
          submitFunction: register,
          submitLabel: 'Criar Conta',
        ),
      ),
    );
  }

  List<Function> getRegisterFormValidators() {
    List<Function> validators = FormUtils.registerValidators();

    validators.removeLast();
    validators.add((String text) => FormUtils.validateConfirmPswd(text, pswdController.text));

    return validators;
  }

  List<TextEditingController> getRegisterFormControllers() => [
        nameController,
        userController,
        pswdController,
        confirmPswdController,
      ];

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
}
