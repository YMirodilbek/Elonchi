part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();
}

final class InitialTimerEvent extends OtpEvent {
  final int? initialSeconds;
  const InitialTimerEvent({this.initialSeconds});

  @override
  List<Object?> get props => [initialSeconds];
}

final class ChangeCodeEvent extends OtpEvent {
  final String code;
  const ChangeCodeEvent({required this.code});

  @override
  List<Object> get props => [code];
}

final class TickEvent extends OtpEvent {
  const TickEvent();

  @override
  List<Object> get props => [];
}

class ConfirmOtp extends OtpEvent {
  final String number;
  const ConfirmOtp({required this.number});

  @override
  List<Object> get props => [number];
}

class ResendOtp extends OtpEvent {
  final String number;
  const ResendOtp({required this.number});

  @override
  List<Object> get props => [number];
}
