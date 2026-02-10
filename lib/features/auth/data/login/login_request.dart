class LoginRequest {
  final String? phoneNumber;
  final String? fcmToken;

  LoginRequest({this.phoneNumber, this.fcmToken});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      LoginRequest(phoneNumber: json["phone_number"], fcmToken: json["firebase_token"]);

  Map<String, dynamic> toJson() => {"phone": phoneNumber, "firebase_token": fcmToken};
}
