import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/home/data/banner_response.dart';
import 'package:elonchi/features/home/data/products_response.dart';
import 'package:elonchi/features/home/domain/entities/get_product_request.dart';

abstract class HomeRepo {
  Future<ResponseData<void>> likeItem(int itemId);
  Future<ResponseData<void>> getLikedItems();
  Future<ResponseData<void>> getWatchingItems();
  Future<ResponseData<void>> watchItem(int itemId);
  Future<ResponseData<void>> deleteWatchingItem(int itemId);
  Future<ResponseData<List<BannerDataResponse>>> getBannerData();
  Future<ResponseData<ProductsResponsePaginated>> getProducts(GetProductRequest request);
  Future<ResponseData<ProductsResponsePaginated>> getRecentItems();
}

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl(this.requestManager);
  final RequestManager requestManager;

  @override
  Future<ResponseData<void>> deleteWatchingItem(int itemId) {
    return requestManager.request(requestType: RequestType.delete, path: PUrls.deleteWatchItem(itemId));
  }

  @override
  Future<ResponseData<List<BannerDataResponse>>> getBannerData() {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getBanners,
      dataParser: (jsonData) {
        return (jsonData as List?)?.map((e) => BannerDataResponse.fromJson(e)).toList() ?? [];
      },
    );
  }

  @override
  Future<ResponseData<void>> getLikedItems() {
    return requestManager.request(requestType: RequestType.get, path: PUrls.getLikedItems);
  }

  @override
  Future<ResponseData<ProductsResponsePaginated>> getProducts(GetProductRequest request) {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getSearchProducts,
      queryParameters: request.toJson(),
      dataParser: (jsonData) => ProductsResponsePaginated.fromJson(jsonData),
    );
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

  @override
  Future<ResponseData<ProductsResponsePaginated>> getRecentItems() {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getRecentItems,
      dataParser: (jsonData) => ProductsResponsePaginated.fromJson(jsonData),
    );
  }
}
