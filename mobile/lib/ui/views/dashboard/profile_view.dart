import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermedications/ui/components/custom_text.dart';
import 'package:usermedications/ui/provider/user_provider.dart';
import 'package:usermedications/core/model/user.dart';
import 'package:usermedications/ui/services/user_service.dart';
import 'package:usermedications/core/utils/utils.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User _user;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  _getData() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);

    User user = provider.user;

    if (user == null) {
      List<String> prefData = await UserService().getUserPrefs();

      var result =
          await provider.fetchUser(prefData[0], int.parse(prefData[1]));

      if (result.runtimeType == String) {
        if (result == 'offline')
          showOfflineDialog(context);
        else
          showMessageDialog(context, 'Há algo de errado...', result, null);
      } else
        user = provider.user;
    }

    setState(() => _user = user);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      height: double.maxFinite,
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 75, left: 60),
      color: Colors.grey[50],
      child: Consumer<UserProvider>(builder: (context, provider, child) {
        if (_user == null && provider.running) {
          return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
            Color.fromRGBO(50, 205, 100, .9),
          ));
        } else if (_user == null && !provider.running) {
          return CustomText(
              text:
                  'Aconteceu algum erro ao recuperar suas informações... Tente novamente mais tarde!');
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Perfil',
                fontSize: 32,
                isBold: true,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              CustomText(text: "Nome: ${_user.name}", fontSize: 18,),
              CustomText(text: "Nome de usuário: ${_user.user}", fontSize: 18,),
            ],
          );
        }
      }),
    ));
  }

  _editUser() {}
}
