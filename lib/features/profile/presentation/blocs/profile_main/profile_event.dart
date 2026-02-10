part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class ChangeLoggedIn extends ProfileEvent {
  const ChangeLoggedIn();
  @override
  List<Object> get props => [];
}

final class GetUserEvent extends ProfileEvent {
  const GetUserEvent();
  @override
  List<Object> get props => [];
}
