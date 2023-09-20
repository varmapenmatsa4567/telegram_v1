import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/auth_provider.dart';
import 'package:telegram_v1/providers/data_provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';
import 'package:telegram_v1/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox<bool>("status");
  await Hive.openBox<Map<String, dynamic>>("user");

  // Run the app
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => DataProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        fontFamily: GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        fontFamily: GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
