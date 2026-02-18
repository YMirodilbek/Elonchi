import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/my_products/data/product_item_response.dart';

abstract class MyItemsRepo {
  Future<ResponseData<List<ProductResponse>>> getItems();
  Future<ResponseData<void>> deleteItem();
}

class MyItemsRepoImpl extends MyItemsRepo {
  final RequestManager requestManager;
  MyItemsRepoImpl(this.requestManager);
  @override
  Future<ResponseData<void>> deleteItem() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseData<List<ProductResponse>>> getItems() {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getMyProducts,
      dataParser: (jsonData) => (jsonData as List).map((e) => ProductResponse.fromJson(e)).toList(),
    );
  }
}
