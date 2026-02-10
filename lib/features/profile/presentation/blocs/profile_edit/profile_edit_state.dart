part of 'profile_edit_bloc.dart';

class ProfileEditState extends Equatable {
  final UserModel userModel;
  final ApiStatus apiStatus;

  const ProfileEditState({required this.userModel, required this.apiStatus});

  @override
  List<Object> get props => [userModel, apiStatus];

  ProfileEditState copyWith({bool? loggedIn, UserModel? userModel, ApiStatus? apiStatus}) {
    return ProfileEditState(userModel: userModel ?? this.userModel, apiStatus: apiStatus ?? this.apiStatus);
  }
}
