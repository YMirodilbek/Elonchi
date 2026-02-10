part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

final class OnChanged extends LoginEvent {
  final String number;
  const OnChanged({required this.number});

  @override
  List<Object> get props => [number];
}

final class OnChangedCountyCode extends LoginEvent {
  final String code;
  const OnChangedCountyCode({required this.code});

  @override
  List<Object> get props => [code];
}

class Login extends LoginEvent {
  const Login();

  @override
  List<Object> get props => [];
}

class ResendOtp extends LoginEvent {
  const ResendOtp();

  @override
  List<Object> get props => [];
}

class ClearOtpSession extends LoginEvent {
  const ClearOtpSession();

  @override
  List<Object> get props => [];
}

class GetRemainingOtpTime extends LoginEvent {
  const GetRemainingOtpTime();

  @override
  List<Object> get props => [];
}

class OtpTimerTick extends LoginEvent {
  const OtpTimerTick();

  @override
  List<Object> get props => [];
}
