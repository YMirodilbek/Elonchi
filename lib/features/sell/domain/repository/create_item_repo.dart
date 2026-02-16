import 'package:dio/dio.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/sell/data/create_item_request.dart';
import 'package:elonchi/features/sell/data/product_item_response.dart';

abstract class CreateItemRepo {
  Future<ResponseData<ProductModel>> createProduct(CreateProductRequest request);
  Future<ResponseData<void>> getItems();
  Future<ResponseData<void>> deleteItem();
}

class CreateItemRepoImpl extends CreateItemRepo {
  final RequestManager requestManager;
  CreateItemRepoImpl(this.requestManager);

  @override
  Future<ResponseData<ProductModel>> createProduct(CreateProductRequest request) async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('title', request.title ?? ''),
      MapEntry('price', request.price ?? ''),
      MapEntry('money_type', request.moneyType ?? ''),
      MapEntry('trade', request.trade.toString()),
      MapEntry('exchange', request.exchange.toString()),
      MapEntry('dostafca', request.dostafca.toString()),
      MapEntry('address', request.address ?? ''),
      MapEntry('phone_number', request.phoneNumber ?? ''),
      MapEntry('description', request.description ?? ''),
      MapEntry('lan', request.lan ?? ''),
      MapEntry('lat', request.lat ?? ''),
      MapEntry('region', request.region ?? ''),
      MapEntry('category', request.category ?? ''),
    ]);

    for (final file in request.images!) {
      formData.files.add(
        MapEntry('image', await MultipartFile.fromFile(file.path, filename: file.path.split('/').last)),
      );
    }

    return requestManager.request<ProductModel>(
      requestType: RequestType.post,
      path: PUrls.createProduct,
      dataParser: (json) => ProductModel.fromJson(json),
      data: formData,
    );
  }

  @override
  Future<ResponseData<void>> getItems() {
    // TODO: implement getItems
    throw UnimplementedError();
  }

  @override
  Future<ResponseData<void>> deleteItem() {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }
}
