import 'package:flutter/material.dart';
import 'package:usermedications/components/custom_text.dart';
import 'package:usermedications/components/medkit_icon.dart';
import 'package:usermedications/utils/nav_utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: onTapLogout,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: 'Sair',
                      color: Colors.grey[800],
                      fontSize: 15,
                      isBold: true,
                    ),
                    Container(child: Icon(Icons.exit_to_app)),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  CustomText(
                    text: 'Medicamentos',
                    textAlign: TextAlign.left,
                    fontSize: 28,
                    isBold: true,
                  ),
                  MedkitIcon(
                    iconSize: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapLogout() {
    NavUtils.pop(context);
  }
}
