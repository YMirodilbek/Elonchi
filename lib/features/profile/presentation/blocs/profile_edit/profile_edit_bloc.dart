import 'dart:io';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/profile/data/edit_request.dart';
import 'package:elonchi/features/profile/data/user_response.dart';
import 'package:elonchi/features/profile/domain/repositories/profile_reporisitory.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final ProfileRepository reporisitory;
  ProfileEditBloc({required this.reporisitory})
    : super(
        ProfileEditState(userModel: UserModel(), apiStatus: ApiStatus.initial, controller: TextEditingController()),
      ) {
    on<EditProfileEvent>(editProfile);
    on<EditProfileInfoEvent>(editProfileName);
    on<InitControllerEvent>(initController);
    on<ChangeUserImgEvent>(onImagePicker);
  }

  void editProfile(EditProfileEvent event, Emitter<ProfileEditState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await reporisitory.editUserInfo(
      request: ProfileEditRequest(firstName: event.userModel.firstName, imageFile: state.pickedImg),
    );
    if (result.ok) {
      emit(state.copyWith(apiStatus: ApiStatus.success, userModel: result.data));
    }
  }

  void editProfileName(EditProfileInfoEvent event, Emitter<ProfileEditState> emit) {
    emit(state.copyWith(userModel: event.userModel));
  }

  void initController(InitControllerEvent event, Emitter<ProfileEditState> emit) {
    emit(state.copyWith(controller: event.controller));
  }

  void onImagePicker(ChangeUserImgEvent event, Emitter<ProfileEditState> emit) async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      final File pickedImg = File(img.path);
      emit(state.copyWith(pickedImg: pickedImg));
    }
  }
}
