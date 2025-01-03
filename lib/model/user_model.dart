class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String? profilePicUrl;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    this.profilePicUrl,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? profilePicUrl,
  }) {
    return UserModel(
      uid: uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      profilePicUrl: data['profilePicUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicUrl': profilePicUrl,
    };
  }
}
