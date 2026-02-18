import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/categories/data/category_response.dart';

abstract class CategoriesRepo {
  Future<ResponseData<List<CategoryResponse>>> getCategories();
  Future<ResponseData<List<CategoryResponse>>> getSubCategories({required int categoryId});
}

class CategoriesRepoImpl extends CategoriesRepo {
  final RequestManager requestManager;
  CategoriesRepoImpl(this.requestManager);

  @override
  Future<ResponseData<List<CategoryResponse>>> getCategories() {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getCategories,
      dataParser: (jsonData) {
        return (jsonData as List).map((e) => CategoryResponse.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<ResponseData<List<CategoryResponse>>> getSubCategories({required int categoryId}) {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getSubCategories(categoryId),
      dataParser: (jsonData) {
        return (jsonData as List).map((e) => CategoryResponse.fromJson(e)).toList();
      },
    );
  }
}
