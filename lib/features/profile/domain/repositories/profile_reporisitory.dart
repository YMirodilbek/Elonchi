import 'package:dio/dio.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/profile/data/edit_request.dart';
import 'package:elonchi/features/profile/data/user_response.dart';

abstract class ProfileRepository {
  Future<ResponseData<UserModel>> getUserInfo();
  Future<ResponseData<UserModel>> editUserInfo({required ProfileEditRequest request});
}

class ProfileRepoImpl extends ProfileRepository {
  final RequestManager requestManager;
  ProfileRepoImpl(this.requestManager);

  @override
  Future<ResponseData<UserModel>> editUserInfo({required ProfileEditRequest request}) async {
    final formData = FormData.fromMap({
      if (request.firstName != null) 'first_name': request.firstName,
      if (request.lastName != null) 'last_name': request.lastName,
      if (request.imageFile != null)
        'image': await MultipartFile.fromFile(
          request.imageFile!.path,
          filename: request.imageFile!.path.split('/').last,
        ),
    });

    return requestManager.request<UserModel>(
      requestType: RequestType.post,
      path: PUrls.editUser,
      dataParser: (json) => UserModel.fromJson(json),
      data: formData,
      contentType: 'multipart/form-data',
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
