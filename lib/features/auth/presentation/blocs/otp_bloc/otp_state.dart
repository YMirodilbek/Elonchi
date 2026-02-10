part of 'otp_bloc.dart';

class OtpState extends Equatable {
  const OtpState(
      {required this.seconds,
      required this.code,
      required this.nickname,
      required this.hasError,
      required this.errorText,
      this.veryfyResponse,
      this.status = ApiStatus.initial});

  final int seconds;
  final String code;
  final VerifySmsResponse? veryfyResponse;
  final ApiStatus status;
  final bool nickname;
  final String errorText;
  final bool hasError;

  OtpState copyWith({
    bool? nickname,
    String? errorText,
    bool? hasError,
    int? seconds,
    String? code,
    VerifySmsResponse? veryfyResponse,
    ApiStatus? status,
  }) {
    return OtpState(
      nickname: nickname ?? this.nickname,
      errorText: errorText ?? this.errorText,
      hasError: hasError ?? this.hasError,
      seconds: seconds ?? this.seconds,
      code: code ?? this.code,
      status: status ?? this.status,
      veryfyResponse: veryfyResponse ?? this.veryfyResponse,
    );
  }

  @override
  List<Object?> get props =>
      [seconds, code, veryfyResponse, status, errorText, hasError, nickname];
}
