import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermedications/ui/animation/FadeAnimation.dart';
import 'package:usermedications/ui/components/custom_form.dart';
import 'package:usermedications/ui/components/custom_text.dart';
import 'package:usermedications/ui/components/medkit_icon.dart';
import 'package:usermedications/core/controller/facade.dart';
import 'package:usermedications/ui/provider/medication_provider.dart';
import 'package:usermedications/ui/provider/user_provider.dart';
import 'package:usermedications/ui/pages/dashboard_page.dart';
import 'package:usermedications/ui/pages/register_page.dart';
import 'package:usermedications/core/utils/form_utils.dart';
import 'package:usermedications/core/utils/nav_utils.dart';
import 'package:usermedications/core/utils/system_colors.dart';
import 'package:usermedications/core/utils/utils.dart';

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

    SystemColors.authColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                makeHeader(),
                makeLoginForm(),
                makeFooter(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget makeHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 35, right: 35, top: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimation(
            1,
            Hero(
              tag: 'medkit-logo',
              child: MedkitIcon(iconSize: 96),
            ),
          ),
          SizedBox(height: 20),
          FadeAnimation(
            1.2,
            CustomText(
              text: "Login",
              fontSize: 54,
              isBold: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: FadeAnimation(
              1.4,
              CustomText(
                text: "Entre e usufrua de nossos serviços!",
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeLoginForm() {
    return FadeAnimation(
      1.6,
      CustomForm(
        this.formKey,
        FormUtils.makeLoginFormOptions(getLoginFormControllers()),
        FormUtils.makeSubmitProp(
          submitFunction: login,
          submitLabel: 'Entrar',
        ),
      ),
    );
  }

  Widget makeFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: FadeAnimation(
        1.8,
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

  List<TextEditingController> getLoginFormControllers() => [
        userController,
        pswdController,
      ];

  void login() async {
    if (formKey.currentState.validate()) {
      showLoadingDialog(context);

      String user = userController.text;
      String pswd = pswdController.text;

      var data = await Facade().login(user, pswd);

      if (data.runtimeType == String) {
        closeDialog(context);

        if (data == 'offline') {
          showOfflineDialog(context);
        } else {
          showMessageDialog(
            context,
            "Há algo de errado...",
            data,
            null,
          );
        }
      } else {
        UserProvider userProvider = new UserProvider();

        bool result = await userProvider.setUser(data);

        closeDialog(context);

        if (!result)
          showMessageDialog(
            context,
            'Há algo de errado...',
            'Houve um erro ao salvar seus dados básicos. Infelizmente não é possível prosseguir. Por favor, contate o suporte.',
            null,
          );
        else
          NavUtils.push(
            context: context,
            page: DashboardPage(),
            replace: true,
          );
      }
    }
  }
}
