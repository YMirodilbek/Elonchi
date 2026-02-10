part of 'profile_edit_bloc.dart';

sealed class ProfileEditEvent extends Equatable {
  const ProfileEditEvent();
}

final class EditProfileEvent extends Equatable {
  const EditProfileEvent(this.userModel);
  final UserModel userModel;

  @override
  List<Object> get props => [userModel];
}
