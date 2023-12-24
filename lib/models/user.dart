class User {
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? phone;
  final String? address;
  final String? image;
  final String? token;
  final String? role;
  final DateTime? dateAdded;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.image,
    this.token,
    this.role,
    this.dateAdded,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
      image: json['image'],
      token: json['token'],
      role: json['role'],
      dateAdded:
          json['dateAdded'] != null ? DateTime.parse(json['dateAdded']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'image': image,
      'token': token,
      'role': role,
      'dateAdded': dateAdded?.toIso8601String(),
    };
  }
}
