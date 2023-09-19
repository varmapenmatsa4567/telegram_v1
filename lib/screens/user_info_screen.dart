import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/models/user_model.dart';
import 'package:telegram_v1/providers/auth_provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';
import 'package:telegram_v1/screens/home_screen.dart';
import 'package:telegram_v1/utils/info_display.dart';
import 'package:telegram_v1/utils/pickers.dart';
import 'package:telegram_v1/widgets/circle_icon_button.dart';
import 'package:telegram_v1/widgets/custom_textfield.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  File? image;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: tp.colors["backgroundColor"],
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: selectImage,
                            child: image == null
                                ? CircleAvatar(
                                    backgroundColor: tp.colors["primaryColor"],
                                    radius: 40,
                                    child: Icon(Icons.add_a_photo, size: 30),
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(image!),
                                    radius: 40,
                                  ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Profile Info",
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
                            "Enter your name and add a profile picture.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: tp.colors["secondaryTextColor"],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                            hintText: "First Name (required)",
                            controller: firstNameController,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                            hintText: "Last Name (optional)",
                            controller: lastNameController,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "By signing up,\nyou agree to the Terms of Service."),
                        CircleIconButton(
                            icon: Icons.arrow_forward,
                            onPressed: () => storeData())
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phoneNumber: "",
      uid: "",
      profilePic: "",
    );

    if (image == null) {
      showSnackBar(context, "Please upload your profile photo");
    } else {
      ap.saveToCloud(
        context: context,
        userModel: userModel,
        image: image!,
        onSuccess: () {
          ap.saveToLocal();
          Get.offAll(() => HomeScreen());
        },
      );
    }
  }
}
