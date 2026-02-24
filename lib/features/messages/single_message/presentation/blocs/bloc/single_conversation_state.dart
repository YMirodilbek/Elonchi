part of 'single_conversation_bloc.dart';

class SingleConversationState extends Equatable {
  final bool hasNextPag;
  final List<MessageResponse> messages;
  final ApiStatus overAllApiStatus;
  final ApiStatus sendMessageApiStatus;
  final ConversationRequest conversationRequest;
  const SingleConversationState({
    this.hasNextPag = false,
    this.messages = const [],
    this.sendMessageApiStatus = ApiStatus.initial,
    this.overAllApiStatus = ApiStatus.loading,
    this.conversationRequest = const ConversationRequest(
      message: '',
      product: ProductMessage(),
      userId: 0,
      userName: '',
      type: SmsType.buyer,
    ),
  });

  @override
  List<Object?> get props => [conversationRequest, overAllApiStatus, sendMessageApiStatus, messages, hasNextPag];

  SingleConversationState copyWith({
    bool? hasNextPag,
    List<MessageResponse>? messages,
    ConversationRequest? conversationRequest,
    ApiStatus? overAllApiStatus,
    ApiStatus? sendMessageApiStatus,
  }) {
    return SingleConversationState(
      messages: messages ?? this.messages,
      hasNextPag: hasNextPag ?? this.hasNextPag,
      conversationRequest: conversationRequest ?? this.conversationRequest,
      overAllApiStatus: overAllApiStatus ?? this.overAllApiStatus,
      sendMessageApiStatus: sendMessageApiStatus ?? this.sendMessageApiStatus,
    );
  }
}
