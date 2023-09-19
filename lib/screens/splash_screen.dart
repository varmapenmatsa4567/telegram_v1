// SplashScreen
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/auth_provider.dart';
import 'package:telegram_v1/screens/home_screen.dart';
import 'package:telegram_v1/screens/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get AuthProvider
    final ap = Provider.of<AuthProvider>(context, listen: false);

    // Switch to welcome screen after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (ap.isAuth)
        Get.offAll(() => HomeScreen());
      else
        Get.to(() => WelcomeScreen());
    });

    return Scaffold(
      backgroundColor: Color(0xFF1F2732),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/telegramIcon.png",
        width: 180,
        height: 180,
      ),
    );
  }
}
