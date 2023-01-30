class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String token;
  final String address;
  final String type;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.token,
      required this.type,
      this.address = ''});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        token: map['token'] ?? '',
        type: map['userType'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "password": password,
      "userType": type,
      "token": token,
    };
  }
}
