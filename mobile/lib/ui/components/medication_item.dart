import 'package:flutter/material.dart';
import 'package:usermedications/ui/components/custom_text.dart';
import 'package:usermedications/core/model/medication.dart';

class MedicationItem extends StatelessWidget {
  final Medication medication;

  MedicationItem({this.medication});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 4,
          ),
        ],
        color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: medication.name,
                fontSize: 18,
                isBold: true,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 4),
              CustomText(
                text: "Valor: ${medication.value}",
                fontSize: 14,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 4),
              medication.description.isNotEmpty
                  ? CustomText(
                      text: medication.description,
                      fontSize: 12,
                      textAlign: TextAlign.left,
                    )
                  : Container(),
            ],
          ),
        ],
      ),
      width: 150,
      margin: EdgeInsets.all(5),
    );
  }
}
