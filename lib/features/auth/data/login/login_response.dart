class WelcomeResponse {
  final String? detail;

  WelcomeResponse({
    this.detail,
  });

  factory WelcomeResponse.fromJson(Map<String, dynamic> json) => WelcomeResponse(
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
  };
}
