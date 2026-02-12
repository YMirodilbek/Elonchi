part of 'profile_edit_bloc.dart';

sealed class ProfileEditEvent extends Equatable {
  const ProfileEditEvent();
}

final class EditProfileEvent extends ProfileEditEvent {
  const EditProfileEvent(this.userModel);
  final UserModel userModel;

  @override
  List<Object> get props => [userModel];
}

final class EditProfileInfoEvent extends ProfileEditEvent {
  final UserModel userModel;

  const EditProfileInfoEvent(this.userModel);

  @override
  List<Object> get props => [userModel];
}
