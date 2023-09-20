import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:telegram_v1/models/user_model.dart';

class DataProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _userModel;

  // Getters
  UserModel get userModel => _userModel!;

  DataProvider() {
    getUserData().then((UserModel userModel) {
      _userModel = userModel;
      print(_userModel);
      notifyListeners();
    });
  }

  // Get user data from cloud firestore
  Future<UserModel> getUserData() async {
    String uid = _auth.currentUser!.uid;
    Map<String, dynamic> data = {};
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection("users").doc(uid).get();
      data = documentSnapshot.data()!;
    } catch (e) {
      print(e);
    }
    return UserModel.fromMap(data);
  }
}
