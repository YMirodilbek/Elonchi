import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';

abstract class MessagesRepo {
  Future<ResponseData<void>> getChatList();
  Future<ResponseData<void>> createRoom({required int userId, required int productId});
  Future<ResponseData<void>> sendMessage({required int id});
  Future<ResponseData<void>> getChatMessages({required int chatId});
  Future<ResponseData<void>> deleteChat({required int chatId});
}

class MessagesRepoImpl extends MessagesRepo {
  final RequestManager requestManager;
  MessagesRepoImpl(this.requestManager);
  @override
  Future<ResponseData<void>> createRoom({required int userId, required int productId}) {
    return requestManager.request(
      requestType: RequestType.post,
      path: PUrls.createRoom,
      data: {"user_2_id": userId, "product_id": productId},
    );
  }

  @override
  Future<ResponseData<void>> deleteChat({required int chatId}) {
    return requestManager.request(requestType: RequestType.delete, path: PUrls.deleteChat(chatId));
  }

  @override
  Future<ResponseData<void>> getChatList() {
    return requestManager.request(requestType: RequestType.get, path: PUrls.getChatList);
  }

  @override
  Future<ResponseData<void>> getChatMessages({required int chatId}) {
    return requestManager.request(requestType: RequestType.get, path: PUrls.getChatMessages(chatId));
  }

  @override
  Future<ResponseData<void>> sendMessage({required int id}) {
    return requestManager.request(requestType: RequestType.post, path: PUrls.sendMessage(id));
  }
}
