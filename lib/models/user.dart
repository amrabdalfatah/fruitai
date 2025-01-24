class UserModel {
  final String id;
  final String name;
  final String email;
  final String language;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.language,

  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      language: data['language'],
    );
  }
}