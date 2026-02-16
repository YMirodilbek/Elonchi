part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class ChangeLoggedIn extends ProfileEvent {
  final bool value;
  const ChangeLoggedIn(this.value);
  @override
  List<Object> get props => [value];
}

final class GetUserEvent extends ProfileEvent {
  const GetUserEvent();
  @override
  List<Object> get props => [];
}

final class EditProfileInfoEvent extends ProfileEvent {
  final UserModel userModel;

  const EditProfileInfoEvent(this.userModel);

  @override
  List<Object> get props => [userModel];
}
