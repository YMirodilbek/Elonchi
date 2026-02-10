part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool loggedIn;
  final UserModel userModel;
  final ApiStatus apiStatus;

  const ProfileState({required this.loggedIn, required this.userModel, required this.apiStatus});

  @override
  List<Object> get props => [loggedIn, userModel, apiStatus];

  ProfileState copyWith({bool? loggedIn, UserModel? userModel, ApiStatus? apiStatus}) {
    return ProfileState(
      loggedIn: loggedIn ?? this.loggedIn,
      userModel: userModel ?? this.userModel,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }
}
