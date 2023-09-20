// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:telegram_v1/providers/theme_provider.dart";

class SidebarItem extends StatelessWidget {
  SidebarItem({required this.title, required this.icon});

  String title;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    return InkWell(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(icon, color: Color(0xFF7d8d9a), size: 25),
            ),
            Text(
              title,
              style: TextStyle(
                color: tp.colors["textColor"],
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
