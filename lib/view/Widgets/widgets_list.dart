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

class WidgetList with ChangeNotifier {
  Widget sensorAddButton(
      {required String buttonText,
      required onTap,
      bool sensorAddIcon = false,
      required Enum buttonColor,
      Enum textColor = sensorButtonColor.white,
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
                    color: buttonC(buttonColor: textColor),
                    fontWeight: FontWeight.bold),
              ),
            ),
            sensorAddIcon
                ? Icon(
                    Icons.add_circle_outline,
                    size: 29,
                    color: buttonC(buttonColor: textColor),
                  )
                : const SizedBox()
          ],
        ),
        decoration: BoxDecoration(
            color: buttonC(buttonColor: buttonColor),
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
              buttonColor: sensorButtonColor.lightBlue,
              buttonText: "Allow",
              onTap: onTap,
              textColor: sensorButtonColor.black);
        }

      case ButtonType.denyButton:
        {
          return sensorAddButton(
            context: context,
            buttonColor: sensorButtonColor.blue,
            buttonText: "Deny",
            onTap: onTap,
          );
        }

      case ButtonType.lnAddSensor:
        {
          return sensorAddButton(
              context: context,
              buttonColor: sensorButtonColor.blue,
              buttonText: "LN sensor",
              onTap: onTap,
              sensorAddIcon: true);
        }
      case ButtonType.jnAddSensor:
        {
          return sensorAddButton(
            context: context,
            buttonColor: sensorButtonColor.blue,
            buttonText: "JN sensor",
            sensorAddIcon: true,
            onTap: onTap,
          );
        }
      case ButtonType.secondAddSensor:
        {
          return sensorAddButton(
            context: context,
            buttonColor: sensorButtonColor.gray,
            buttonText: "Add sensor",
            sensorAddIcon: true,
            textColor: sensorButtonColor.black,
            onTap: onTap,
          );
        }
      default:
        {
          return sensorAddButton(
            context: context,
            buttonColor: sensorButtonColor.lightBlue,
            buttonText: "Allow",
            onTap: onTap,
          );
        }
    }
  }
}
