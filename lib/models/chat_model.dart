
class ChatModel {
  final String lastMessage, time, profilePhoto, username, email;

  ChatModel(
      {required this.lastMessage,
      required this.time,
      required this.profilePhoto,
      required this.username,
      required this.email});

  factory ChatModel.fromJson(jsonData) {
    return ChatModel(
      lastMessage: jsonData["lastMessage"],
      time: jsonData["time"],
      profilePhoto: jsonData["profilePhoto"],
      username: jsonData["username"],
      email: jsonData['email'],
    );
  }
}
