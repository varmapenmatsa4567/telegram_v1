import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/data_provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';
import 'package:telegram_v1/widgets/chat_input.dart';
import 'package:telegram_v1/widgets/contact_card.dart';
import 'package:telegram_v1/widgets/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [
    "Hello",
    "How are you?",
    "I am fine",
    "What about you?",
    "I am also fine",
    "How is your family?",
    "They are fine",
    "What about yours?",
    "They are also fine",
    "That's great",
    "Yes",
    "Bye",
  ];
  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: false);
    final dp = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: tp.colors["appBarColor"],
          titleSpacing: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: tp.colors["appBarTitleColor"],
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: ContactCard(
            name: dp.selectedChat["name"],
            lastSeen: "last seen recently",
            profilePic: dp.selectedChat["profilePic"],
            phoneNumber: dp.selectedChat["phoneNumber"],
            uid: dp.selectedChat["uid"],
            chat: true,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.call),
              color: tp.colors["appBarTitleColor"],
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              color: tp.colors["appBarTitleColor"],
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 180, 150, 150),
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index % 2 == 0) {
                      return Message(
                        isMe: false,
                        message: messages[index],
                      );
                    }
                    return Message(
                      isMe: true,
                      message: messages[index],
                    );
                  },
                ),
              ),
            ),
            Container(
              color: tp.colors["chatInputColor"],
              width: double.infinity,
              child: ChatInput(),
            )
          ],
        ));
  }
}
