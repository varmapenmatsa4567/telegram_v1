import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/models/chat_model.dart';
import 'package:telegram_v1/providers/data_provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';
import 'package:telegram_v1/screens/chat_screen.dart';

class ContactCard extends StatelessWidget {
  String name;
  String lastSeen;
  String profilePic;
  String phoneNumber;
  String uid;
  bool chat;
  ContactCard(
      {required this.name,
      required this.lastSeen,
      required this.profilePic,
      required this.phoneNumber,
      required this.uid,
      this.chat = false});

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    final dp = Provider.of<DataProvider>(context, listen: true);
    print(name);
    return InkWell(
      onTap: () {
        dp.setSelectedChat({
          "name": name,
          "profilePic": profilePic,
          "phoneNumber": phoneNumber,
          "uid": uid
        });
        Get.to(() => ChatScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                profilePic,
              ),
              radius: 25,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: chat ? Colors.white : tp.colors["textColor"],
                    ),
                  ),
                  Text(
                    lastSeen,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: chat
                          ? tp.colors["drawerSecondaryTextColor"]
                          : tp.colors["secondaryTextColor"],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createChat() {
    final dp = Provider.of<DataProvider>(Get.context!, listen: false);
    List<String> users = [
      dp.userModel.phoneNumber.toString().substring(1),
      phoneNumber.substring(1)
    ];
    users.sort();
    String chatId = users[0] + users[1];
    ChatModel chatModel =
        ChatModel(name: chatId, users: users, lastMessage: "");
    dp.createChat(chatId, chatModel);
  }
}
