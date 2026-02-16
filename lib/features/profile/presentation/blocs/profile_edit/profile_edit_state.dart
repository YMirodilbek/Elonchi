part of 'profile_edit_bloc.dart';

class ProfileEditState extends Equatable {
  final UserModel userModel;
  final ApiStatus apiStatus;
  final TextEditingController controller;
  final File? pickedImg;

  const ProfileEditState({required this.userModel, required this.apiStatus, required this.controller, this.pickedImg});

  @override
  List<Object?> get props => [userModel, apiStatus, controller, pickedImg];

  ProfileEditState copyWith({
    bool? loggedIn,
    UserModel? userModel,
    ApiStatus? apiStatus,
    File? pickedImg,
    TextEditingController? controller,
  }) {
    return ProfileEditState(
      pickedImg: pickedImg ?? this.pickedImg,
      userModel: userModel ?? this.userModel,
      apiStatus: apiStatus ?? this.apiStatus,
      controller: controller ?? this.controller,
    );
  }
}
