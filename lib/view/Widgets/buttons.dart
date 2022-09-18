import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors.dart';
enum ButtonType {
  lnAddSensor,
  jnAddSensor,
  secondAddSensor,
  acceptButton,
  denyButton
}

  Widget sensorAddButton(
      {required String buttonText,
      required onTap,
      bool sensorAddIcon = false,
      required Enum buttonColor,
      Enum textColor = ColorsLists.white,
      required BuildContext context}) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: 168,
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 18, left: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: sensorAddIcon
                  ? const EdgeInsets.only(right: 10)
                  : const EdgeInsets.only(right: 0),
              child: Text(
                buttonText,
                style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    fontSize: 16,
                    color: colorsList(colorsList: textColor),
                    fontWeight: FontWeight.bold),
              ),
            ),
            sensorAddIcon
                ? Icon(
                    Icons.add_circle_outline,
                    size: 29,
                    color: colorsList(colorsList: textColor),
                  )
                : const SizedBox()
          ],
        ),
        decoration: BoxDecoration(
            color: colorsList(colorsList: buttonColor),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget buttonSelect(
      {required buttonType, required onTap, required BuildContext context}) {
    switch (buttonType) {
      case ButtonType.acceptButton:
        {
          return sensorAddButton(
              context: context,
              buttonColor: ColorsLists.lightBlue,
              buttonText: "Allow",
              onTap: onTap,
              textColor: ColorsLists.black);
        }

      case ButtonType.denyButton:
        {
          return sensorAddButton(
            context: context,
            buttonColor: ColorsLists.blue,
            buttonText: "Deny",
            onTap: onTap,
          );
        }

      case ButtonType.lnAddSensor:
        {
          return sensorAddButton(
              context: context,
              buttonColor: ColorsLists.blue,
              buttonText: "LN sensor",
              onTap: onTap,
              sensorAddIcon: true);
        }
      case ButtonType.jnAddSensor:
        {
          return sensorAddButton(
            context: context,
            buttonColor: ColorsLists.blue,
            buttonText: "JN sensor",
            sensorAddIcon: true,
            onTap: onTap,
          );
        }
      case ButtonType.secondAddSensor:
        {
          return sensorAddButton(
            context: context,
            buttonColor: ColorsLists.gray,
            buttonText: "Add sensor",
            sensorAddIcon: true,
            textColor: ColorsLists.black,
            onTap: onTap,
          );
        }
      default:
        {
          return sensorAddButton(
            context: context,
            buttonColor: ColorsLists.lightBlue,
            buttonText: "Allow",
            onTap: onTap,
          );
        }
    }
  }