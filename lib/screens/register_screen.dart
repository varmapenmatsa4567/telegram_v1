// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:provider/provider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:telegram_v1/providers/auth_provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';
import 'package:telegram_v1/widgets/circle_icon_button.dart';
import 'package:telegram_v1/widgets/custom_container.dart';
import 'package:telegram_v1/widgets/custom_keypad.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Country Picker
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    name: "India",
    level: 1,
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  // Phone Number Controller
  TextEditingController _controller = TextEditingController();

  // Keypad number button press events
  void addInput(String number) {
    HapticFeedback.heavyImpact();
    if (_controller.text.length > 13) return;
    _controller.text = _controller.text + number;
  }

  // Keypad backspace button press events
  void backSpace() {
    _controller.text =
        _controller.text.substring(0, _controller.text.length - 1);
  }

  // phone number validation
  bool isValid() {
    if (_controller.text.length == 10) return true;
    return false;
  }

  // value to decide shake effect of phone number field
  bool _autoPlay = false;

  // function to shake phone number field
  void shake() {
    setState(() {
      _autoPlay = true;
    });
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _autoPlay = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    final ap = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: tp.colors["backgroundColor"],
      body: SafeArea(
        child: ap.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: tp.colors["primaryColor"],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your phone number",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: tp.colors["textColor"],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Please confirm your country code\nand enter your phone number.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: tp.colors["secondaryTextColor"],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                setState(() {
                                  selectedCountry = country;
                                });
                              },
                            );
                          },
                          child: CustomContainer(
                            text: "Country",
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${selectedCountry.flagEmoji}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "${selectedCountry.name}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: tp.colors["textColor"],
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: tp.colors["secondaryTextColor"],
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        ShakeWidget(
                          autoPlay: _autoPlay,
                          shakeConstant: ShakeHorizontalConstant1(),
                          child: CustomContainer(
                            text: "Phone number",
                            textColor: _autoPlay
                                ? Colors.red
                                : tp.colors["primaryColor"],
                            borderColor: _autoPlay
                                ? Colors.red
                                : tp.colors["primaryColor"],
                            borderWidth: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 55,
                                  child: Text(
                                    "+${selectedCountry.phoneCode}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: tp.colors["textColor"],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  child: VerticalDivider(
                                    color: tp.colors["secondaryTextColor"],
                                    thickness: 1,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 7),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: TextField(
                                        controller: _controller,
                                        autofocus: true,
                                        keyboardType: TextInputType.none,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: tp.colors["textColor"],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: CircleIconButton(
                                icon: Icons.arrow_forward,
                                onPressed: () {
                                  if (!isValid()) {
                                    shake();
                                    return;
                                  }
                                  sendPhoneNumber();
                                })),
                        SizedBox(
                          height: 20,
                        ),
                        CustomKeypad(controller: _controller),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber =
        "+${selectedCountry.phoneCode}${_controller.text.trim()}";
    ap.sendOtp(context, phoneNumber);
  }
}
