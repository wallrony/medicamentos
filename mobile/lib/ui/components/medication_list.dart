import 'package:flutter/material.dart';
import 'package:usermedications/ui/animation/FadeAnimation.dart';
import 'package:usermedications/ui/components/custom_text.dart';
import 'package:usermedications/ui/components/medication_item.dart';
import 'package:usermedications/ui/provider/medication_provider.dart';

class MedicationList extends StatelessWidget {
  final MedicationProvider medProvider;
  final Function redirectToAddMedication;
  final Function onItemTap;

  MedicationList({
    this.medProvider,
    this.redirectToAddMedication,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    if (medProvider.running &&
        (medProvider.medications == null || medProvider.medications.isEmpty)) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else if (medProvider.medications == null ||
        medProvider.medications.isEmpty)
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeAnimation(
              1.8,
              Container(
                child: CustomText(
                  text: "Não encontrei nenhum medicamento...",
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            FadeAnimation(
              2,
              FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: Color.fromRGBO(50, 205, 100, 1),
                ),
                onPressed: () => redirectToAddMedication(),
              ),
            ),
          ],
        ),
      );

    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                medProvider.medications.length,
            itemBuilder: (context, index) {
              final edgeItem = GestureDetector(
                onTap: () => onItemTap(medProvider.medications[index]),
                child: Container(
                  child: MedicationItem(
                    medication: medProvider.medications[index],
                  ),
                  padding: EdgeInsets.only(
                    left: index == 0 ? 15 : 0,
                    right: index == medProvider.medications.length - 1
                        ? 15
                        : 0,
                  ),
                ),
              );

              final normalItem = GestureDetector(
                onTap: () => onItemTap(medProvider.medications[index]),
                child: MedicationItem(
                  medication: medProvider.medications[index],
                ),
              );

              return index == 0 || index == medProvider.medications.length - 1
                  ? edgeItem
                  : normalItem;
            }
          ),
        ),
        FadeAnimation(
          2,
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(50, 205, 100, .8),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => redirectToAddMedication(),
          ),
        ),
      ],
    );
  }
}
