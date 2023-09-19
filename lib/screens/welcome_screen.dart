import "package:flutter/material.dart";
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import 'package:telegram/providers/auth_provider.dart';
// import 'package:telegram/providers/theme_provider.dart';
// import 'package:telegram/screens/home_screen.dart';
// import 'package:telegram/screens/register_screen.dart';
import 'package:telegram_v1/providers/theme_provider.dart';
import 'package:telegram_v1/screens/register_screen.dart';
import 'package:telegram_v1/widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Map<String, String>> welcomeWords = [
    {
      "title": "Telegram",
      "content": "The world's fastest messaging app.\nIt is free and secure."
    },
    {
      "title": "Fast",
      "content":
          "Telegram delivers messages\nfaster than any other application."
    },
    {
      "title": "Free",
      "content":
          "Telegram provides free unlimited\ncloud storage for chats and media."
    },
    {
      "title": "Powerful",
      "content": "Telegram has no limits on\nthe size of your media and chats."
    },
    {
      "title": "Secure",
      "content": "Telegram keeps your messages safe\nfrom hacker attacks."
    },
    {
      "title": "Cloud-Based",
      "content":
          "Telegram lets you access your\nmessages from multiple devices."
    }
  ];

  List<String> images = [
    "telegramIcon",
    "fast",
    "free",
    "power",
    "security",
    "cloud"
  ];

  int ind = 0;

  @override
  Widget build(BuildContext context) {
    CarouselController _controller = CarouselController();
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: tp.colors["backgroundColor"],
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 80),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        tp.toggleTheme();
                      },
                      child: Icon(
                        tp.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                        color: tp.colors["primaryColor"],
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Image.asset(
                    "assets/${images[ind]}.png",
                    width: 160,
                    height: 160,
                  ),
                  ExpandableCarousel(
                    options: CarouselOptions(
                      height: 400.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          ind = index;
                        });
                      },
                      showIndicator: true,
                      controller: _controller,
                      slideIndicator: CircularSlideIndicator(
                        indicatorRadius: 2,
                        itemSpacing: 8,
                        indicatorBackgroundColor:
                            tp.colors["secondaryTextColor"],
                        currentIndicatorColor: tp.colors["primaryColor"],
                      ),
                    ),
                    items: welcomeWords.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.only(top: 20, bottom: 30),
                            child: Column(
                              children: [
                                Text(
                                  "${i['title']}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: tp.colors["textColor"],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("${i['content']}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      wordSpacing: .5,
                                      fontSize: 14,
                                      color: tp.colors["secondaryTextColor"],
                                    )),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                child: CustomButton(
                  onPressed: () {
                    Get.to(() => RegisterScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
