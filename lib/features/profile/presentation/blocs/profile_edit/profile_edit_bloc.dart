import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/profile/data/user_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(ProfileEditState(userModel: UserModel(), apiStatus: ApiStatus.initial)) {
    on<ProfileEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
