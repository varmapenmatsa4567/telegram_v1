import 'package:flutter/material.dart';

// Dark theme colors
Map<String, Color> dark = {
  "backgroundColor": Color(0xFF181818),
  "primaryColor": Color(0xFF50A7EA),
  "textColor": Colors.white,
  "secondaryTextColor": Color(0xFF868686),
  "keypadBackgroundColor": Color(0xFF242424),
  "appBarColor": Color(0xFF252d3a),
  "channelTileColor": Color(0xff1d2733),
  "pinnedChannelTileColor": Color(0xff242e38),
  "appBarTitleColor": Colors.white,
  "drawerHeaderColor": Color(0xff233040),
  "drawerBodyColor": Color(0xff1c242f),
  "drawerSecondaryTextColor": Color(0xff7b8fa1),
  "contactDividerColor": Color(0xff141c27),
  "chatAppBarColor": Color(0xff242326),
  "chatInputColor": Color(0xFF252d3a),
  "messageRightColor": Color(0xff508d51),
  "messageLeftColor": Color(0xff20221f),
};

// Light theme colors
Map<String, Color> light = {
  "backgroundColor": Colors.white,
  "primaryColor": Color(0xFF50a7ea),
  "textColor": Color(0xFF181818),
  "secondaryTextColor": Color(0xFF999999),
  "keypadBackgroundColor": Color(0xfff0f0f0),
  "appBarColor": Color(0xFF517da2),
  "channelTileColor": Colors.white,
  "pinnedChannelTileColor": Color(0xfff7f7f7),
  "appBarTitleColor": Colors.white,
  "drawerHeaderColor": Color(0xff5a8fbb),
  "drawerBodyColor": Colors.white,
  "drawerSecondaryTextColor": Color(0xffbee5ff),
  "contactDividerColor": Color(0xfff5f5f5),
  "chatAppBarColor": Color(0xff6877ae),
  "chatInputColor": Color(0xffffffff),
  "messageRightColor": Color(0xffeaf2b9),
  "messageLeftColor": Color(0xffffffff),
};

class ThemeProvider extends ChangeNotifier {
  // Variables
  bool _isDarkTheme = true;
  Map<String, Color> _colors = dark;

  // Getters
  get isDarkTheme => _isDarkTheme;
  get colors => _colors;

  // Toggle theme
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _colors = _isDarkTheme ? dark : light;
    notifyListeners();
  }
}
