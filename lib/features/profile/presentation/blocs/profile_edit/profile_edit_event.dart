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

final class InitControllerEvent extends ProfileEditEvent {
  final TextEditingController controller;
  const InitControllerEvent(this.controller);
  @override
  List<Object> get props => [controller];
}

final class ChangeUserImgEvent extends ProfileEditEvent {
  const ChangeUserImgEvent();

  @override
  List<Object?> get props => [];
}
