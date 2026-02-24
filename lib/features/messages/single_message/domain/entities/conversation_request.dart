import 'package:elonchi/features/messages/all_messages/data/chat_list_response.dart';
import 'package:elonchi/features/messages/all_messages/domain/repository/all_massages_repo.dart';

class ConversationRequest {
  final ProductMessage product;
  final String previousRoute;
  final String message;
  final String phoneNumber;
  final String? imageUrl;
  final int userId;
  final String userName;
  final int? chatId; //if chat Id exist, than we dont create a room,
  final SmsType type;

  const ConversationRequest({
    required this.previousRoute,
    required this.product,
    this.imageUrl,
    required this.message,
    required this.phoneNumber,
    required this.userId,
    required this.type,
    this.chatId,
    required this.userName,
  });

  ConversationRequest copyWith({
    String? previousRoute,
    String? imageUrl,
    String? phoneNumber,
    String? message,
    int? itemId,
    int? userId,
    String? userName,
    int? chatId,
    SmsType? type,
  }) {
    return ConversationRequest(
      previousRoute: previousRoute ?? this.previousRoute,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      product: product,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      chatId: chatId ?? this.chatId,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'previousRoute': previousRoute,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'product': product.toJson(),
      'message': message,
      'userId': userId,
      'userName': userName,
      'chatId': chatId,
      'type': type.name,
    };
  }

  factory ConversationRequest.fromJson(Map<String, dynamic> json) {
    return ConversationRequest(
      previousRoute: json['previousRoute'] as String,
      imageUrl: json['imageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      product: ProductMessage.fromJson(json['product'] as Map<String, dynamic>),
      message: json['message'] as String,
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      chatId: json['chatId'] as int?,
      type: SmsType.values.firstWhere((e) => e.name == json['type']),
    );
  }
}
