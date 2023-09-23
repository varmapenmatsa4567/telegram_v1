class UserModel {
  String uid;
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePic;
  bool isOnline;
  String lastSeen;
  String bio;
  String username;
  List<String> chats = [];

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePic,
    this.isOnline = true,
    this.lastSeen = "Online",
    this.bio = "",
    this.username = "",
    this.chats = const [],
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      profilePic: json["profilePic"] ?? "",
      isOnline: json["isOnline"] ?? true,
      lastSeen: json["lastSeen"] ?? "Online",
      bio: json["bio"] ?? "",
      username: json["username"] ?? "",
      chats: json["chats"] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "profilePic": profilePic,
      "isOnline": isOnline,
      "lastSeen": lastSeen,
      "bio": bio,
      "username": username,
      "chats": chats,
    };
  }
}
