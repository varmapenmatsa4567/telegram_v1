// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:provider/provider.dart";
import "package:telegram_v1/providers/theme_provider.dart";

class NewActionCard extends StatelessWidget {
  NewActionCard({required this.title, required this.icon});

  String title;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: icon == FontAwesomeIcons.bullhorn ? 26 : 23),
              child: Icon(icon,
                  color: Color(0xFF7d8d9a),
                  size: icon == FontAwesomeIcons.bullhorn ? 20 : 25),
            ),
            Text(
              title,
              style: TextStyle(
                color: tp.colors["textColor"],
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
