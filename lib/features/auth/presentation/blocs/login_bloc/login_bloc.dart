import 'dart:async';
import 'package:elonchi/features/auth/data/login/login_response.dart';
import 'package:elonchi/injector_container.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/response_data.dart';
import '../../../data/login/login_request.dart';
import '../../../domain/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  Timer? _otpTimer;

  LoginBloc({required this.authRepository}) : super(LoginState(number: '', countryCode: '+998')) {
    on<OnChanged>(_onChangeNumber);
    on<Login>(_onLogin);
    on<OnChangedCountyCode>(_onCodeChange);
    on<ResendOtp>(_onResendOtp);
    on<ClearOtpSession>(_onClearOtpSession);
    on<GetRemainingOtpTime>(_onGetRemainingOtpTime);
    on<OtpTimerTick>(_onOtpTimerTick);
  }

  void _onChangeNumber(OnChanged event, Emitter<LoginState> emit) {
    // Check if the new number is different from the last OTP number
    final newFullNumber = "${state.countryCode} ${event.number.trim()}";
    if (state.lastOtpPhoneNumber != null && state.lastOtpPhoneNumber != newFullNumber) {
      // Clear OTP session if number changed
      _stopOtpTimer();
      emit(state.copyWith(number: event.number, lastOtpPhoneNumber: null, otpExpiryTime: null, remainingOtpSeconds: 0));
    } else {
      emit(state.copyWith(number: event.number));
    }
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    final fullPhoneNumber = "${state.countryCode} ${state.number.trim()}";

    // Check if same number and OTP is still valid
    if (_isSameNumberAndOtpValid(fullPhoneNumber)) {
      // Skip API request, go directly to OTP screen
      emit(state.copyWith(welcomeStatus: ApiStatus.success, remainingOtpSeconds: _calculateRemainingSeconds()));

      // Start timer if not already running
      _startOtpTimer();

      emit(state.copyWith(welcomeStatus: ApiStatus.initial));
      return;
    }

    emit(state.copyWith(welcomeStatus: ApiStatus.loading));

    final result = await authRepository.login(
      LoginRequest(phoneNumber: fullPhoneNumber, fcmToken: localSource.fcmToken),
    );
    if (result.ok) {
      // Store OTP session info
      final otpExpiryTime = DateTime.now().add(Duration(minutes: 2));

      emit(
        state.copyWith(
          welcomeResponse: result.data,
          welcomeStatus: ApiStatus.success,
          lastOtpPhoneNumber: fullPhoneNumber,
          otpExpiryTime: otpExpiryTime,
          remainingOtpSeconds: 120,
        ),
      );

      // Start the timer
      _startOtpTimer();

      emit(state.copyWith(welcomeStatus: ApiStatus.initial));
    } else {
      emit(state.copyWith(welcomeStatus: ApiStatus.error));
    }
  }

  // Helper method to check if same number and OTP is still valid
  bool _isSameNumberAndOtpValid(String currentNumber) {
    if (state.lastOtpPhoneNumber == null || state.otpExpiryTime == null) {
      return false;
    }

    final isSameNumber = state.lastOtpPhoneNumber == currentNumber;
    final isOtpStillValid = DateTime.now().isBefore(state.otpExpiryTime!);

    return isSameNumber && isOtpStillValid;
  }

  void _onCodeChange(OnChangedCountyCode event, Emitter<LoginState> emit) {
    emit(state.copyWith(countryCode: event.code));
  }

  void _onResendOtp(ResendOtp event, Emitter<LoginState> emit) async {
    final fullPhoneNumber = "${state.countryCode} ${state.number.trim()}";

    emit(state.copyWith(welcomeStatus: ApiStatus.loading));

    final result = await authRepository.login(LoginRequest(phoneNumber: fullPhoneNumber));

    if (result.ok) {
      // Update OTP session info
      final otpExpiryTime = DateTime.now().add(Duration(minutes: 2));

      emit(
        state.copyWith(
          welcomeResponse: result.data,
          welcomeStatus: ApiStatus.success,
          lastOtpPhoneNumber: fullPhoneNumber,
          otpExpiryTime: otpExpiryTime,
          remainingOtpSeconds: 120, // 2 minutes in seconds
        ),
      );

      // Restart the timer
      _startOtpTimer();

      emit(state.copyWith(welcomeStatus: ApiStatus.initial));
    } else {
      emit(state.copyWith(welcomeStatus: ApiStatus.error));
    }
  }

  void _onClearOtpSession(ClearOtpSession event, Emitter<LoginState> emit) {
    _stopOtpTimer();
    emit(state.copyWith(lastOtpPhoneNumber: null, otpExpiryTime: null, remainingOtpSeconds: 0));
  }

  void _onGetRemainingOtpTime(GetRemainingOtpTime event, Emitter<LoginState> emit) {
    final remainingSeconds = _calculateRemainingSeconds();
    emit(state.copyWith(remainingOtpSeconds: remainingSeconds));
  }

  // Helper method to get remaining OTP time in seconds
  int get remainingOtpSeconds => state.remainingOtpSeconds;

  DateTime? get otpExpiryTime => state.otpExpiryTime;

  @override
  Future<void> close() {
    _stopOtpTimer();
    return super.close();
  }

  void _onOtpTimerTick(OtpTimerTick event, Emitter<LoginState> emit) {
    final remainingSeconds = _calculateRemainingSeconds();

    if (remainingSeconds <= 0) {
      // Timer expired, clear OTP session
      _stopOtpTimer();
      emit(state.copyWith(lastOtpPhoneNumber: null, otpExpiryTime: null, remainingOtpSeconds: 0));
    } else {
      emit(state.copyWith(remainingOtpSeconds: remainingSeconds));
    }
  }

  // Helper method to calculate remaining seconds
  int _calculateRemainingSeconds() {
    if (state.otpExpiryTime == null) return 0;

    final now = DateTime.now();
    if (now.isAfter(state.otpExpiryTime!)) return 0;

    return state.otpExpiryTime!.difference(now).inSeconds;
  }

  // Start the OTP timer
  void _startOtpTimer() {
    _stopOtpTimer(); // Stop any existing timer

    _otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(OtpTimerTick());
    });
  }

  // Stop the OTP timer
  void _stopOtpTimer() {
    _otpTimer?.cancel();
    _otpTimer = null;
  }
}
