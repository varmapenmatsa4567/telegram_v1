// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:telegram_v1/models/user_model.dart';
import 'package:telegram_v1/screens/home_screen.dart';
import 'package:telegram_v1/screens/otp_screen.dart';
import 'package:telegram_v1/utils/info_display.dart';

class AuthProvider extends ChangeNotifier {
  // Variables
  bool _isAuth = false;
  Box _statusBox = Hive.box<bool>("status");
  Box _userBox = Hive.box<UserModel>("user");
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  String _verificationId = "";
  String _uid = "";
  String _phoneNumber = "";
  UserModel? _userModel;

  // Getters
  bool get isAuth => _isAuth;
  bool get loading => isLoading;
  String get uid => _uid;
  String get phoneNumber => _phoneNumber;

  // Constructor
  AuthProvider() {
    checkSignIn();
  }

  // Check if user is signed in
  void checkSignIn() {
    _isAuth = _statusBox.get("status") ?? false;
    notifyListeners();
  }

  // Toggle Auth
  void toggleAuth() {
    _isAuth = !_isAuth;
    _statusBox.put("status", _isAuth);
    notifyListeners();
  }

  // Toggle Loading
  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  // signInWith Phone Number
  void sendOtp(BuildContext context, String phoneNumber) async {
    toggleLoading();
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            toggleLoading();
            await _auth.signInWithCredential(credential);
            toggleAuth();
            showSnackBar(context, "Login Successful");
            Get.offAll(() => HomeScreen());
          },
          verificationFailed: (error) {
            toggleLoading();
            showSnackBar(context, error.message.toString());
          },
          codeSent: (String verificationId, int? resendToken) {
            _verificationId = verificationId;
            _phoneNumber = phoneNumber;
            toggleLoading();
            Get.to(() => OtpScreen());
          },
          codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {});
    } on FirebaseAuthException catch (e) {
      toggleLoading();
      showSnackBar(context, e.message.toString());
    }
  }

  // Verify OTP
  void verifyOtp(
      BuildContext context, String otp, VoidCallback onSuccess) async {
    toggleLoading();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: otp);
      User user = (await _auth.signInWithCredential(credential)).user!;
      toggleLoading();
      if (user != null) {
        _uid = user.uid;
        showSnackBar(context, "Login Successful");
        onSuccess();
      } else {
        showSnackBar(context, "Login Failed");
      }
    } on FirebaseAuthException catch (e) {
      toggleLoading();
      showSnackBar(context, e.message.toString());
    }
  }

  // Check if user exists in the database
  Future<bool> checkExistingUser() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(_uid).get();
    if (documentSnapshot.exists) {
      print("User Exists");
      toggleAuth();
      return true;
    } else {
      print("User Doesn't Exist");
      return false;
    }
  }

  // Store file to firebase storage
  Future<String> storeFile(String ref, File image) async {
    UploadTask uploadTask = _storage.ref(ref).putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  // Save user data to Firebase
  void saveToCloud({
    required BuildContext context,
    required UserModel userModel,
    required File image,
    required VoidCallback onSuccess,
  }) async {
    toggleLoading();
    try {
      await storeFile("profilePic/${_uid}", image).then((url) async {
        userModel.profilePic = url;
        userModel.uid = _uid;
        userModel.phoneNumber = _phoneNumber;
        _userModel = userModel;

        await _firestore
            .collection("users")
            .doc(_uid)
            .set(userModel.toMap())
            .then((value) {
          toggleAuth();
          toggleLoading();
          onSuccess();
        });
      });
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // Save user data to Hive
  void saveToLocal() {
    _userBox.put("user", _userModel);
  }
}
