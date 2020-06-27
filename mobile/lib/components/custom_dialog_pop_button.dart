import 'package:flutter/material.dart';
import 'package:usermedications/components/custom_button.dart';
import 'package:usermedications/utils/utils.dart';

class CustomDialogPopButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: CustomIconButton(
        label: 'Ok',
        onPressed: () => closeDialog(context),
        reverseColors: true,
        icon: Icon(Icons.close),
      ),
    );
  }
}
