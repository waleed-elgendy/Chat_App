class Message {
  final String message, id;

  Message(
    this.message,
    this.id,
  );
  factory Message.fromJson(jsonData) {
    return Message(jsonData['messages'],jsonData['id']);
  }
}
