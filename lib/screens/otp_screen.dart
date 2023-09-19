import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/auth_provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';
import 'package:telegram_v1/screens/home_screen.dart';
import 'package:telegram_v1/screens/user_info_screen.dart';
import 'package:telegram_v1/widgets/custom_keypad.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: tp.colors["backgroundColor"],
      body: SafeArea(
        child: isLoading
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
                          "Enter Code",
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
                          "We've sent an SMS with an activation code to your phone\n+91 9494567964",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: tp.colors["secondaryTextColor"],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Pinput(
                          onCompleted: (value) => verifyOtp(context, value),
                          submittedPinTheme: PinTheme(
                            width: 35,
                            height: 45,
                            textStyle: TextStyle(
                              color: tp.colors["textColor"],
                            ),
                            decoration: BoxDecoration(
                              color: tp.colors["backgroundColor"],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: tp.colors["primaryColor"],
                                width: 2,
                              ),
                            ),
                          ),
                          defaultPinTheme: PinTheme(
                            width: 35,
                            height: 45,
                            textStyle: TextStyle(
                              color: tp.colors["textColor"],
                            ),
                            decoration: BoxDecoration(
                              color: tp.colors["backgroundColor"],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: tp.colors["secondaryTextColor"],
                                width: 2,
                              ),
                            ),
                          ),
                          length: 6,
                          keyboardType: TextInputType.none,
                          controller: _controller,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        CustomKeypad(controller: _controller),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String otp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(context, otp, () {
      ap.checkExistingUser().then((value) async {
        if (value == true) {
          Get.offAll(() => HomeScreen());
        } else {
          Get.offAll(() => UserInfoScreen());
        }
      });
    });
  }
}
