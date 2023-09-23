import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:telegram_v1/models/chat_model.dart';
import 'package:telegram_v1/models/user_model.dart';

class DataProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _userModel;
  List<Map<String, String>>? _contacts;
  List<Map<String, dynamic>> _matchedContacts = [];
  Map<String, dynamic> _selectedChat = {};

  // Getters
  get userModel => _userModel;
  get contacts => _contacts;
  get matchedContacts => _matchedContacts;
  get selectedChat => _selectedChat;

  DataProvider() {
    getUserData().then((UserModel userModel) {
      _userModel = userModel;
      print(_userModel);
      notifyListeners();
    });
    getContacts();
    getMatchedContacts();
  }

  // Set selected chat
  void setSelectedChat(Map<String, dynamic> chat) {
    _selectedChat = chat;
    notifyListeners();
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

  // Get list of users
  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("users").get();
      querySnapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
        users.add(UserModel.fromMap(doc.data()!));
      });
    } catch (e) {
      print(e);
    }
    return users;
  }

  // Get list of phone numbers
  Future getPhoneNumbers() async {
    List<String> phoneNumbers = [];
    List<Map<String, String>> contacts = await getContacts();
    try {
      for (Map<String, String> contact in contacts) {
        phoneNumbers.add(contact["phoneNumber"]!);
      }
      return phoneNumbers;
    } catch (e) {
      print(e);
    }
  }

  // Get list of contacts
  Future getContacts() async {
    List<Contact> contacts = [];
    List<Map<String, String>> phoneNumbers = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
      for (Contact contact in contacts) {
        if (contact.phones.length > 0) {
          phoneNumbers.add({
            "displayName": contact.displayName,
            "phoneNumber": contact.phones.first.normalizedNumber
          });
        }
      }
      _contacts = phoneNumbers;
      // print(_contacts);
      return phoneNumbers;
    } catch (e) {
      print(e);
    }
  }

  // Get macthing contacts usermodel and contacts
  Future getMatchedContacts() async {
    List<Map<String, dynamic>> matchedContacts = [];
    List<Map<String, String>> contacts = await getContacts();
    List<UserModel> users = await getUsers();
    try {
      for (Map<String, String> contact in contacts) {
        for (UserModel user in users) {
          if (contact["phoneNumber"] == user.phoneNumber) {
            matchedContacts.add({
              "displayName": contact["displayName"],
              "phoneNumber": contact["phoneNumber"],
              "profilePic": user.profilePic,
              "uid": user.uid,
            });
          }
        }
      }
      _matchedContacts = matchedContacts;
      return matchedContacts;
    } catch (e) {
      print(e);
    }
  }

  // Check whether chat exists or not
  Future isChatExists(String chatId) async {
    bool isExists = false;
    try {
      _firestore
          .collection("chats")
          .doc(chatId)
          .get()
          .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          isExists = true;
        }
      });
    } catch (e) {
      print(e);
    }
    return isExists;
  }

  // Create chat
  Future createChat(String chatId, ChatModel chatMode) async {
    bool isExists = await isChatExists(chatId);
    try {
      if (!isExists)
        _firestore.collection("chats").doc(chatId).set(chatMode.toMap());
    } catch (e) {
      print(e);
    }
  }
}
