class UserModel {
  final String? firstName;
  final String? lastName;

  const UserModel({this.firstName, this.lastName});

  /// Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(firstName: json['first_name'] as String?, lastName: json['last_name'] as String?);
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {'first_name': firstName, 'last_name': lastName};
  }

  /// CopyWith
  UserModel copyWith({String? firstName, String? lastName}) {
    return UserModel(firstName: firstName ?? this.firstName, lastName: lastName ?? this.lastName);
  }
}
