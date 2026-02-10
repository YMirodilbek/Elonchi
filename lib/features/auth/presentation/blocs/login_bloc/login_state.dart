part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.countryCode,
    required this.number,
    this.welcomeResponse,
    this.welcomeStatus = ApiStatus.initial,
    this.lastOtpPhoneNumber,
    this.otpExpiryTime,
    this.remainingOtpSeconds = 0,
  });

  final String countryCode;
  final String number;
  final WelcomeResponse? welcomeResponse;
  final ApiStatus welcomeStatus;
  final String? lastOtpPhoneNumber;
  final DateTime? otpExpiryTime;
  final int remainingOtpSeconds;

  LoginState copyWith({
    String? countryCode,
    String? number,
    WelcomeResponse? welcomeResponse,
    ApiStatus? welcomeStatus,
    String? lastOtpPhoneNumber,
    DateTime? otpExpiryTime,
    int? remainingOtpSeconds,
  }) {
    return LoginState(
      countryCode: countryCode ?? this.countryCode,
      number: number ?? this.number,
      welcomeResponse: welcomeResponse ?? this.welcomeResponse,
      welcomeStatus: welcomeStatus ?? this.welcomeStatus,
      lastOtpPhoneNumber: lastOtpPhoneNumber ?? this.lastOtpPhoneNumber,
      otpExpiryTime: otpExpiryTime ?? this.otpExpiryTime,
      remainingOtpSeconds: remainingOtpSeconds ?? this.remainingOtpSeconds,
    );
  }

  @override
  List<Object?> get props => [
        number,
        welcomeResponse,
        welcomeStatus,
        countryCode,
        lastOtpPhoneNumber,
        otpExpiryTime,
        remainingOtpSeconds,
      ];
}
