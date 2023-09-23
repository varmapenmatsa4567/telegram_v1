class ChatModel {
  String name;
  List<String> profilePic;
  List<String> users;
  String admin;
  String lastMessage;
  String lastMessageTime;
  String lastMessageSender;
  String type;

  ChatModel({
    required this.name,
    this.profilePic = const [],
    this.users = const [],
    this.admin = "",
    this.lastMessage = "",
    this.lastMessageTime = "",
    this.lastMessageSender = "",
    this.type = "",
  });

  factory ChatModel.fromMap(Map<String, dynamic> json) {
    return ChatModel(
      name: json["name"] ?? "",
      profilePic: json["profilePic"] ?? [],
      users: json["users"] ?? [],
      admin: json["admin"] ?? "",
      lastMessage: json["lastMessage"] ?? "",
      lastMessageTime: json["lastMessageTime"] ?? "",
      lastMessageSender: json["lastMessageSender"] ?? "",
      type: json["type"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "profilePic": profilePic,
      "users": users,
      "admin": admin,
      "lastMessage": lastMessage,
      "lastMessageTime": lastMessageTime,
      "lastMessageSender": lastMessageSender,
      "type": type,
    };
  }
}
