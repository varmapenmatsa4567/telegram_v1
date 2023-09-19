// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';

class KeypadButton extends StatelessWidget {
  final onLongPress;
  final String number;
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  KeypadButton({
    this.number = "",
    this.text = "   ",
    this.icon = Icons.check,
    required this.onPressed,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(tp.colors["keypadBackgroundColor"]),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              horizontal: 25, vertical: icon == Icons.check ? 5 : 10)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        onLongPress: onLongPress,
        onPressed: onPressed,
        child: number != ""
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    number,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: tp.colors["textColor"],
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: tp.colors["secondaryTextColor"],
                    ),
                  ),
                ],
              )
            : Icon(
                icon,
                color: Colors.white,
              ));
  }
}
