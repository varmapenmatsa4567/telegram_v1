import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({required this.hintText, required this.controller});

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    return TextField(
      keyboardType: TextInputType.name,
      controller: controller,
      style: TextStyle(
        color: tp.colors["textColor"],
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
        labelText: hintText,
        hintText: hintText,
        labelStyle: TextStyle(
          color: tp.colors["secondaryTextColor"],
        ),
        floatingLabelStyle: TextStyle(
          color: tp.colors["primaryColor"],
        ),
        hintStyle: TextStyle(
          color: tp.colors["secondaryTextColor"],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: tp.colors["secondaryTextColor"],
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: tp.colors["primaryColor"]!,
            width: 2,
          ),
        ),
      ),
    );
  }
}
