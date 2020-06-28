import 'package:flutter/material.dart';
import 'package:usermedications/ui/animation/FadeAnimation.dart';
import 'package:usermedications/ui/components/custom_text.dart';
import 'package:usermedications/ui/components/medkit_icon.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[50],
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 30, left: 45),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(
              1.2,
              Container(
                padding: const EdgeInsets.only(top: 35),
                child: CustomText(
                  text: 'Medicamentos',
                  textAlign: TextAlign.left,
                  fontSize: 38,
                  isBold: true,
                ),
              ),
            ),
            FadeAnimation(
              1.4,
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: double.maxFinite,
                alignment: Alignment.center,
                child: Hero(
                  tag: 'medkit-logo',
                  child: MedkitIcon(
                    iconSize: 128,
                    opacity: 1,
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1.6,
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 50,
                ),
                child: CustomText(
                  text:
                  "Adicione seus medicamentos e tenha um controle melhor da sua saúde!",
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
