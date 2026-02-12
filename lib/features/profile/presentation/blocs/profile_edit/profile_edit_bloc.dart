import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/profile/data/user_response.dart';
import 'package:elonchi/features/profile/domain/repositories/profile_reporisitory.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final ProfileRepository reporisitory;
  ProfileEditBloc({required this.reporisitory})
    : super(ProfileEditState(userModel: UserModel(), apiStatus: ApiStatus.initial)) {
    on<EditProfileEvent>(editProfile);
    on<EditProfileInfoEvent>(editProfileName);
  }

  void editProfile(ProfileEditEvent event, Emitter<ProfileEditState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await reporisitory.editUserInfo(name: state.userModel.firstName);
    if (result.ok) {
      emit(state.copyWith(apiStatus: ApiStatus.success));
    }
  }

  void editProfileName(EditProfileInfoEvent event, Emitter<ProfileEditState> emit) {
    emit(state.copyWith(userModel: event.userModel));
  }
}
