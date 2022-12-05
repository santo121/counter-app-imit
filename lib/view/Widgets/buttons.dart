import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors.dart';
enum ButtonType {
  lnAddSensor,
  jnAddSensor,
  secondAddSensor,
  acceptButton,
  denyButton,
  redirectionButton
}

  Widget sensorAddButton(
      {required String buttonText,
      required onTap,
      bool sensorAddIcon = false,
      required Enum buttonColor,
      Enum textColor = ColorsLists.white,
      required BuildContext context}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape:const StadiumBorder(),
        backgroundColor: colorsList(colorsList: buttonColor),
        elevation: 0
      ),
      child: Container(
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
            ),
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
            sensorAddIcon: false,
            textColor: ColorsLists.black,
            onTap: onTap,
          );
        }
      case ButtonType.redirectionButton:
        {
          return sensorAddButton(
            context: context,
            buttonColor: ColorsLists.blue,
            buttonText: "sensor console",
            sensorAddIcon: false,
            textColor: ColorsLists.white,
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