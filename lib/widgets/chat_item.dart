import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hidden Group V2",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: tp.colors["textColor"],
                      ),
                    ),
                    Text(
                      "1:31 AM",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: tp.colors["secondaryTextColor"],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "This is a message",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: tp.colors["secondaryTextColor"],
                      ),
                    ),
                    Text(
                      "1",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: tp.colors["secondaryTextColor"],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
