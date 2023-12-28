class AllUsersModel {
  final String email, username, profilePhoto;

  AllUsersModel(
      {required this.email,
      required this.username,
      required this.profilePhoto});
  factory AllUsersModel.fromJson(jsonData) {
    return AllUsersModel(
        email: jsonData['email'],
        username: jsonData['username'],
        profilePhoto: jsonData["profilePhoto"]);
  }
}
