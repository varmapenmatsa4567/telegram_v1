// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({
    this.child,
    required this.text,
    this.borderWidth = 1,
    this.borderColor = const Color(0xFF494949),
    this.textColor = const Color(0xff7d7d7d),
  });

  Color textColor;
  Color borderColor;
  double borderWidth;
  final String text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          ),
          child: child,
        ),
        Positioned(
          left: 30,
          top: 12,
          child: Container(
            padding: EdgeInsets.only(bottom: 2, left: 5, right: 5),
            color: tp.colors["backgroundColor"],
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
