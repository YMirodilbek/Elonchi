import 'dart:io';

class ProfileEditRequest {
  final String? firstName;
  final String? lastName;
  final File? imageFile;

  const ProfileEditRequest({this.firstName, this.lastName, this.imageFile});

  ProfileEditRequest copyWith({String? firstName, String? lastName, File? imageFile}) {
    return ProfileEditRequest(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}
