import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/profile/data/user_response.dart';
import 'package:elonchi/features/profile/domain/repositories/profile_reporisitory.dart';
import 'package:elonchi/injector_container.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository reporisitory;
  ProfileBloc({required this.reporisitory})
    : super(ProfileState(loggedIn: localSource.isUserLoggedIn, userModel: UserModel(), apiStatus: ApiStatus.initial)) {
    on<ChangeLoggedIn>(_setLoggedIn);
    on<GetUserEvent>(_getUser);
    on<EditProfileInfoEvent>(editUserInfo);
  }

  void _setLoggedIn(ChangeLoggedIn event, Emitter<ProfileState> emit) {
    emit(state.copyWith(loggedIn: event.value));
  }

  void _getUser(GetUserEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));

    final result = await reporisitory.getUserInfo();
    if (result.ok) {
      emit(state.copyWith(userModel: result.data, apiStatus: ApiStatus.initial));
    } else {
      emit(state.copyWith(userModel: result.data, apiStatus: ApiStatus.error));
    }
  }

  void editUserInfo(EditProfileInfoEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(userModel: event.userModel));
  }
}
