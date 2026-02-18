import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';

abstract class HomeRepo {
  Future<ResponseData<void>> likeItem(int itemId);
  Future<ResponseData<void>> dislikeItem(int itemId);
  Future<ResponseData<void>> getLikedItems();
  Future<ResponseData<void>> getWatchingItems();
  Future<ResponseData<void>> watchItem(int itemId);
  Future<ResponseData<void>> deleteWatchingItem(int itemId);
  Future<ResponseData<void>> getBannerData();
  Future<ResponseData<void>> getProducts();
}

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl(this.requestManager);
  final RequestManager requestManager;

  @override
  Future<ResponseData<void>> deleteWatchingItem(int itemId) {
    return requestManager.request(requestType: RequestType.delete, path: PUrls.deleteWatchItem(itemId));
  }

  @override
  Future<ResponseData<void>> dislikeItem(int itemId) {
    return requestManager.request(requestType: RequestType.delete, path: PUrls.deleteProduct(itemId));
  }

  @override
  Future<ResponseData<void>> getBannerData() {
    return requestManager.request(requestType: RequestType.get, path: PUrls.getBanners);
  }

  @override
  Future<ResponseData<void>> getLikedItems() {
    return requestManager.request(requestType: RequestType.get, path: PUrls.getLikedItems);
  }

  @override
  Future<ResponseData<void>> getProducts() {
    return requestManager.request(requestType: RequestType.get, path: PUrls.getSearchProducts);
  }

  @override
  Future<ResponseData<void>> getWatchingItems() {
    return requestManager.request(requestType: RequestType.get, path: PUrls.getWatchingItems);
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
