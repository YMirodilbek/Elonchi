class WelcomeResponse {
  final int? code;

  WelcomeResponse({this.code});

  factory WelcomeResponse.fromJson(Map<String, dynamic> json) => WelcomeResponse(code: json["code"]);

  Map<String, dynamic> toJson() => {"code": code};
}
