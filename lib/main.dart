import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  runApp(const MyApp());
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
      home: const Text("Hello world!"),
      debugShowCheckedModeBanner: false,
    );
  }
}
