class User {
  int? id;
  String fullName;
  String phoneNumber;
  String email;
  String city;
  String password;

  User({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.city,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'city': city,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      city: map['city'],
      password: map['password'],
    );
  }
}
