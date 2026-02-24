part of 'single_conversation_bloc.dart';

class SingleConversationState extends Equatable {
  final List<File> images;
  final bool hasNextPag;
  final List<MessageResponse> messages;
  final TextEditingController? messageController;
  final ApiStatus overAllApiStatus;
  final ApiStatus sendMessageApiStatus;
  final ConversationRequest conversationRequest;
  const SingleConversationState({
    this.images = const [],
    this.messageController,
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
  List<Object?> get props => [
    conversationRequest,
    overAllApiStatus,
    sendMessageApiStatus,
    messages,
    hasNextPag,
    messageController,
    images,
  ];

  SingleConversationState copyWith({
    List<File>? images,
    TextEditingController? messageController,
    bool? hasNextPag,
    List<MessageResponse>? messages,
    ConversationRequest? conversationRequest,
    ApiStatus? overAllApiStatus,
    ApiStatus? sendMessageApiStatus,
  }) {
    return SingleConversationState(
      images: images ?? this.images,
      messageController: messageController ?? this.messageController,
      messages: messages ?? this.messages,
      hasNextPag: hasNextPag ?? this.hasNextPag,
      conversationRequest: conversationRequest ?? this.conversationRequest,
      overAllApiStatus: overAllApiStatus ?? this.overAllApiStatus,
      sendMessageApiStatus: sendMessageApiStatus ?? this.sendMessageApiStatus,
    );
  }
}
