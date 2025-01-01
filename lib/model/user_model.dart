class UserModel {
  final String firstName;
  final String lastName;
  final String? profilePicUrl;
  final String uid;

  UserModel({
    required this.firstName,
    required this.lastName,
    this.profilePicUrl,
    required this.uid,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      profilePicUrl: data['profilePicUrl'],
      uid: documentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'profilePicUrl': profilePicUrl,
      'uid': uid,
    };
  }
}
