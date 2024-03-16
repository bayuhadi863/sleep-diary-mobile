class UserModel {
  final String id;
  String name;
  String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  static UserModel empty() => UserModel(id: '', name: '', email: '');

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
