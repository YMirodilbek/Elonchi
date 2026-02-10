class VerifySmsResponse {
  final String? detail;
  final String? access;
  final String? refresh;

  VerifySmsResponse({
    this.detail,
    this.access,
    this.refresh,
  });

  factory VerifySmsResponse.fromJson(Map<String, dynamic> json) =>
      VerifySmsResponse(
        detail: json["detail"],
        access: json["access"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
        "access": access,
        "refresh": refresh,
      };
}
