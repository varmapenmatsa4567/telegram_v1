import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/data_provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';
import 'package:telegram_v1/widgets/contact_card.dart';
import 'package:telegram_v1/widgets/new_action_card.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  State<NewChat> createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    final dp = Provider.of<DataProvider>(context, listen: true);
    List<Map<String, dynamic>> fullView = [
      {"title": "New Group", "icon": Icons.group_outlined},
      {"title": "New Secret Chat", "icon": Icons.lock_outline},
      {"title": "New Channel", "icon": FontAwesomeIcons.bullhorn},
    ];
    fullView.add({"divider": true});
    fullView.addAll(dp.matchedContacts);
    return Scaffold(
      backgroundColor: tp.colors["channelTileColor"],
      appBar: AppBar(
        backgroundColor: tp.colors["appBarColor"],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: tp.colors["appBarTitleColor"],
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "New Message",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: tp.colors["appBarTitleColor"],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: tp.colors["appBarTitleColor"],
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: tp.colors["primaryColor"],
        child: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      body: dp.matchedContacts == null
          ? Center(
              child: CircularProgressIndicator(
                color: tp.colors["primaryColor"],
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: fullView.length,
              itemBuilder: (context, index) {
                // print(dp.contacts[index]["displayName"]);
                if (index < 3)
                  return NewActionCard(
                      title: fullView[index]["title"],
                      icon: fullView[index]["icon"]);
                else if (index == 3)
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    width: double.infinity,
                    color: tp.colors["contactDividerColor"],
                    child: Text(
                      "Contacts on Telegram",
                      style: TextStyle(
                        color: tp.colors["secondaryTextColor"],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                return ContactCard(
                  name: fullView[index]["displayName"],
                  lastSeen: "last seen recently",
                  profilePic: fullView[index]["profilePic"],
                  phoneNumber: fullView[index]["phoneNumber"],
                  uid: fullView[index]["uid"],
                );
              },
            ),
    );
  }
}
