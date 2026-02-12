class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? image;
  final bool? isStaff;
  final bool? isActive;

  const UserModel({this.id, this.firstName, this.lastName, this.phoneNumber, this.image, this.isStaff, this.isActive});

  /// Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone'] as String?,
      image: json['image'] as String?,
      isStaff: json['is_staff'] as bool?,
      isActive: json['is_active'] as bool?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phoneNumber,
      'image': image,
      'is_staff': isStaff,
      'is_active': isActive,
    };
  }

  /// CopyWith
  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? image,
    bool? isStaff,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      isStaff: isStaff ?? this.isStaff,
      isActive: isActive ?? this.isActive,
    );
  }
}
