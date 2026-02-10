class ConfirmRequest {
  final String? phoneNumber;
  final String? otp;

  ConfirmRequest({
    this.phoneNumber,
    this.otp,
  });

  factory ConfirmRequest.fromJson(Map<String, dynamic> json) => ConfirmRequest(
        phoneNumber: json["phone_number"],
        otp: json['code'],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "code": otp,
      };
}
