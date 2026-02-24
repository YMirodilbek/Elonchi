import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/messages/all_messages/data/chat_list_response.dart';
import 'package:elonchi/features/messages/all_messages/data/conversation_response.dart';
import 'package:elonchi/features/messages/all_messages/data/send_message_request.dart';
import 'package:elonchi/features/messages/all_messages/data/send_message_response.dart';
import 'package:dio/dio.dart';

enum SmsType { seller, buyer }

abstract class MessagesRepo {
  Future<ResponseData<ChatListResponse>> getChatList({required SmsType type});
  Future<ResponseData<int>> createRoom({required int userId, required int productId, required SmsType type});
  Future<ResponseData<SendMessageResponse>> sendMessage({required int chatId, required SendMessageRequest request});
  Future<ResponseData<ConversationResponse>> getChatMessages({required int chatId, int page = 1});
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
  Future<ResponseData<ConversationResponse>> getChatMessages({required int chatId, int page = 1}) {
    return requestManager.request(
      requestType: RequestType.get,
      path: PUrls.getChatMessages(chatId),
      queryParameters: {'page': page},
      dataParser: (jsonData) => ConversationResponse.fromJson(jsonData),
    );
  }

  @override
  Future<ResponseData<SendMessageResponse>> sendMessage({
    required int chatId,
    required SendMessageRequest request,
  }) async {
    // Create form data for multipart request
    final formData = FormData();
    formData.fields.add(MapEntry('content', request.content));

    // Add images if any
    for (int i = 0; i < request.images.length; i++) {
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(request.images[i].path, filename: request.images[i].path.split('/').last),
        ),
      );
    }

    return requestManager.request(
      requestType: RequestType.post,
      path: PUrls.sendMessage(chatId),
      data: formData,
      dataParser: (jsonData) => SendMessageResponse.fromJson(jsonData),
    );
  }
}
