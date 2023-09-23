import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/data_provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';
import 'package:telegram_v1/screens/new_chat.dart';
import 'package:telegram_v1/widgets/chat_item.dart';
import 'package:telegram_v1/widgets/sidebar_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    final dp = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
        backgroundColor: tp.colors["channelTileColor"],
        appBar: AppBar(
          backgroundColor: tp.colors["appBarColor"],
          title: Text(
            "Telegram",
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
        drawer: Drawer(
          backgroundColor: tp.colors["drawerBodyColor"],
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                decoration: BoxDecoration(
                  color: tp.colors["drawerHeaderColor"],
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            // backgroundColor: tp.colors["primaryColor"],
                            backgroundImage: CachedNetworkImageProvider(
                              dp.userModel != null
                                  ? dp.userModel.profilePic
                                  : "",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              tp.toggleTheme();
                            },
                            child: Icon(tp.isDarkTheme
                                ? Icons.light_mode
                                : Icons.dark_mode),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          dp.userModel != null
                              ? dp.userModel.firstName
                              : "Loading...",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        dp.userModel != null
                            ? dp.userModel.phoneNumber
                            : "Loading...",
                        style: TextStyle(
                          fontSize: 12,
                          color: tp.colors["drawerSecondaryTextColor"],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SidebarItem(title: "New Group", icon: Icons.group_outlined),
              SidebarItem(title: "Contacts", icon: Icons.person_outlined),
              SidebarItem(title: "Calls", icon: Icons.call_outlined),
              SidebarItem(
                  title: "Saved Messages", icon: Icons.bookmark_outline),
              SidebarItem(title: "Settings", icon: Icons.settings_outlined),
              Divider(
                thickness: .3,
                color: tp.colors["drawerSecondaryTextColor"],
              ),
              SidebarItem(
                  title: "Invite Friends", icon: Icons.person_add_outlined),
              SidebarItem(title: "Telegram Features", icon: Icons.help_outline),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: tp.colors["primaryColor"],
          onPressed: () async {
            Get.to(() => NewChat(),
                transition: Transition.rightToLeft,
                duration: Duration(milliseconds: 100));
          },
          child: Icon(Icons.edit, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        body: Container(
            child: ListView(
          children: [
            ChatItem(),
            ChatItem(),
          ],
        )));
  }
}
