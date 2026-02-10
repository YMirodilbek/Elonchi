import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/auth/data/confirm_otp/confirm_otp_request.dart';
import 'package:elonchi/features/auth/data/confirm_otp/confirm_otp_response.dart';

import '../../../constants/constants.dart';
import '../../../core/network/request_manager.dart';
import '../data/login/login_request.dart';
import '../data/login/login_response.dart';

abstract class AuthRepository {
  Future<ResponseData<WelcomeResponse>> login(LoginRequest request);
  Future<ResponseData<VerifySmsResponse>> confirmOtp(ConfirmRequest request);
}

class AuthRepositoryImpl extends AuthRepository {
  final RequestManager requestManager;

  AuthRepositoryImpl({required this.requestManager});

  @override
  Future<ResponseData<WelcomeResponse>> login(LoginRequest request) async {
    return requestManager.request(
      requestType: RequestType.post,
      path: PUrls.login,
      data: request.toJson(),
      dataParser: (json) => WelcomeResponse.fromJson(json),
    );
  }

  @override
  Future<ResponseData<VerifySmsResponse>> confirmOtp(ConfirmRequest request) async {
    return requestManager.request(
      requestType: RequestType.post,
      path: PUrls.confirmOtp,
      dataParser: (json) => VerifySmsResponse.fromJson(json),
      data: request.toJson(),
    );
  }
}
