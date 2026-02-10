import 'dart:async';
import 'package:dio/dio.dart';
import 'package:elonchi/core/local_source/local_source.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/auth/data/confirm_otp/confirm_otp_request.dart';
import 'package:elonchi/features/auth/data/confirm_otp/confirm_otp_response.dart';
import 'package:elonchi/features/auth/data/login/login_request.dart';
import 'package:elonchi/features/auth/domain/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injector_container.dart';
part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _timer;
  final AuthRepository authRepository;
  final LocalSource localSource;

  OtpBloc({required this.authRepository, required this.localSource})
    : super(OtpState(seconds: 120, code: '', hasError: false, errorText: '', nickname: true)) {
    on<InitialTimerEvent>(_onInitialTimerStart);
    on<TickEvent>(_onTick);
    on<ChangeCodeEvent>(_onChangeCode);
    on<ConfirmOtp>(_onConfirmOtp);
    on<ResendOtp>(_onResendOtp);
  }

  void _onInitialTimerStart(InitialTimerEvent event, Emitter<OtpState> emit) {
    _timer?.cancel();

    // Use provided initial seconds or default to 120
    final initialSeconds = event.initialSeconds ?? 120;
    emit(state.copyWith(seconds: initialSeconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(const TickEvent());
    });
  }

  void _onTick(TickEvent event, Emitter<OtpState> emit) {
    if (state.seconds > 0) {
      emit(state.copyWith(seconds: state.seconds - 1));
    } else {
      _timer?.cancel();
    }
  }

  void _onResendOtp(ResendOtp event, Emitter<OtpState> emit) async {
    emit(state.copyWith(status: ApiStatus.loading));

    final result = await authRepository.login(LoginRequest(phoneNumber: event.number));

    if (result.ok) {
      emit(state.copyWith(seconds: 120));
      add(InitialTimerEvent());
    } else {
      emit(state.copyWith(status: ApiStatus.error, errorText: result.error));
    }
  }

  void _onChangeCode(ChangeCodeEvent event, Emitter<OtpState> emit) {
    emit(state.copyWith(code: event.code, hasError: false, errorText: ''));
  }

  void _onConfirmOtp(ConfirmOtp event, Emitter<OtpState> emit) async {
    emit(state.copyWith(status: ApiStatus.loading));

    final result = await authRepository.confirmOtp(ConfirmRequest(phoneNumber: event.number, otp: state.code));

    if (result.ok) {
      emit(state.copyWith(veryfyResponse: result.data));

      // Save tokens to local storage
      if (result.data?.access != null) {
        await localSource.setAccessToken(result.data!.access!);
        sl<Dio>().options.headers["Authorization"] = "Bearer ${result.data!.access!}";
      }
      if (result.data?.refresh != null) {
        await localSource.setRefreshToken(result.data!.refresh!);
      }

      emit(state.copyWith(status: ApiStatus.success));
    } else {
      emit(state.copyWith(status: ApiStatus.error, hasError: true, errorText: result.error));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

String formatToMinutesSeconds(int totalSeconds) {
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;

  final minutesStr = minutes.toString().padLeft(2, '0');
  final secondsStr = seconds.toString().padLeft(2, '0');

  return '$minutesStr:$secondsStr';
}
