import 'package:dio/dio.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/my_products/data/create_item_request.dart';
import 'package:elonchi/features/my_products/data/edit_item_request.dart';
import 'package:elonchi/features/my_products/data/product_item_response.dart';

abstract class CreateItemRepo {
  Future<ResponseData<void>> createProduct(CreateProductRequest request);
  Future<ResponseData<ProductResponse>> editProduct(EditItemRequest request);

  Future<ResponseData<void>> deleteItem();
}

class CreateItemRepoImpl extends CreateItemRepo {
  final RequestManager requestManager;
  CreateItemRepoImpl(this.requestManager);

  @override
  Future<ResponseData<void>> createProduct(CreateProductRequest request) async {
    final formData = FormData();

    final Map<String, dynamic> fields = {
      'title': request.title,
      'price': request.price,
      'money_type': request.moneyType,
      'trade': request.trade == null ? 0 : (request.trade! ? 1 : 0),
      'exchange': request.exchange == null ? 0 : (request.exchange! ? 1 : 0),
      'dostafca': request.dostafca == null ? 0 : (request.dostafca! ? 1 : 0),
      'address': request.address,
      'phone_number': request.phoneNumber,
      'description': request.description,
      'condition': request.condition?.name,
      'lan': request.lan,
      'lat': request.lat,
      'region': request.region?.id,
      'category': request.category?.id,
      'contact_name': request.contactname,
    };

    fields.removeWhere((key, value) => value == null);

    fields.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    if (request.images != null && request.images!.isNotEmpty) {
      for (final file in request.images!) {
        formData.files.add(
          MapEntry('images', await MultipartFile.fromFile(file.path, filename: file.path.split('/').last)),
        );
      }
    }

    /// 5️⃣ Send request
    return requestManager.request(requestType: RequestType.post, path: PUrls.createProduct, data: formData);
  }

  @override
  Future<ResponseData<void>> deleteItem() {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<ResponseData<ProductResponse>> editProduct(EditItemRequest request) {
    final Map<String, dynamic> data = request.toJson();
    return requestManager.request(
      requestType: RequestType.put,
      path: PUrls.editProduct(request.id),
      data: data,
      dataParser: (jsonData) => ProductResponse.fromJson(jsonData['data']),
    );
  }
}
