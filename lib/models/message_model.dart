class MessageModel {
  final String messageText, id, profilePhoto, username, time;

  MessageModel(
    this.messageText,
    this.id,
    this.profilePhoto,
    this.username,
    this.time,
  );
  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData['message'], jsonData['id'],
        jsonData['profilePhoto'], jsonData['username'], jsonData['time'].toString());
  }
}
