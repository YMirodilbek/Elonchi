import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/messages/all_messages/data/chat_list_response.dart';
import 'package:elonchi/features/messages/all_messages/data/conversation_response.dart';

enum SmsType { seller, buyer }

abstract class MessagesRepo {
  Future<ResponseData<ChatListResponse>> getChatList({required SmsType type});
  Future<ResponseData<int>> createRoom({required int userId, required int productId, required SmsType type});
  Future<ResponseData<void>> sendMessage({required int id});
  Future<ResponseData<ConversationResponse>> getChatMessages({required int chatId});
  Future<ResponseData<void>> deleteChat({required int chatId});
}

class MessagesRepoImpl extends MessagesRepo {
  final RequestManager requestManager;
  MessagesRepoImpl(this.requestManager);
  @override
  Future<ResponseData<int>> createRoom({required int userId, required int productId, required SmsType type}) {
    return requestManager.request(
      requestType: RequestType.post,
      path: PUrls.createRoom,
      data: {"user_2_id": userId, "product_id": productId, "type": type.name},
      dataParser: (jsonData) => jsonData['id'],
    );
  }

  @override
  Future<ResponseData<void>> deleteChat({required int chatId}) {
    return requestManager.request(requestType: RequestType.delete, path: PUrls.deleteChat(chatId));
  }

  @override
  Future<ResponseData<ChatListResponse>> getChatList({required SmsType type}) {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getChatList,
      queryParameters: {"type": type.name},
      dataParser: (jsonData) => ChatListResponse.fromJson(jsonData),
    );
  }

  @override
  Future<ResponseData<ConversationResponse>> getChatMessages({required int chatId}) {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getChatMessages(chatId),
      dataParser: (jsonData) => ConversationResponse.fromJson(jsonData),
    );
  }

  @override
  Future<ResponseData<void>> sendMessage({required int id}) {
    return requestManager.request(
      requestType: RequestType.post,
      path: PUrls.sendMessage(id),
      data: {"content": "Test message"},
    );
  }
}
