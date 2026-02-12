import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/profile/data/user_response.dart';

abstract class ProfileRepository {
  Future<ResponseData<UserModel>> getUserInfo();
  Future<ResponseData<void>> editUserInfo({required String? name});
}

class ProfileRepoImpl extends ProfileRepository {
  final RequestManager requestManager;
  ProfileRepoImpl(this.requestManager);

  @override
  Future<ResponseData<void>> editUserInfo({String? name}) {
    return requestManager.request(
      requestType: RequestType.post,
      path: PUrls.editUser,
      dataParser: (json) => UserModel.fromJson(json),
      data: {"first_name": "$name"},
    );
  }

  @override
  Future<ResponseData<UserModel>> getUserInfo() {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getUser,
      dataParser: (json) => UserModel.fromJson(json),
    );
  }
}
