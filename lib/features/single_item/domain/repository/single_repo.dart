import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/single_item/data/single_item_response.dart';

abstract class SingleItemRepo {
  Future<ResponseData<SingleItemResponse>> getItem(int itemId);
  Future<ResponseData<void>> likeItem(int itemId);

  Future<ResponseData<void>> watchItem(int itemId);
  Future<ResponseData<void>> deleteWatchingItem(int itemId);
}

class SingleItemRepoImpl extends SingleItemRepo {
  final RequestManager requestManager;
  SingleItemRepoImpl(this.requestManager);
  @override
  Future<ResponseData<SingleItemResponse>> getItem(int itemId) {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getProductInfo(itemId),
      dataParser: (jsonData) => SingleItemResponse.fromJson(jsonData),
    );
  }

  @override
  Future<ResponseData<void>> deleteWatchingItem(int itemId) {
    return requestManager.request(requestType: RequestType.delete, path: PUrls.deleteWatchItem(itemId));
  }

  @override
  Future<ResponseData<void>> likeItem(int itemId) {
    return requestManager.request(requestType: RequestType.post, path: PUrls.likeProduct, data: {"object_id": itemId});
  }

  @override
  Future<ResponseData<void>> watchItem(int itemId) {
    return requestManager.request(
      requestType: RequestType.post,
      path: PUrls.postWatchItem,
      data: {"product_id": itemId},
    );
  }
}
