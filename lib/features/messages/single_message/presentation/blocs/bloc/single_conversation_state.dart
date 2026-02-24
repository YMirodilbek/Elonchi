part of 'single_conversation_bloc.dart';

class SingleConversationState extends Equatable {
  final List<File> images;
  final bool hasNextPag;
  final List<MessageResponse> messages;
  final TextEditingController? messageController;
  final ApiStatus overAllApiStatus;
  final ApiStatus sendMessageApiStatus;
  final ConversationRequest conversationRequest;
  final ScrollController? scrollController;
  final int page;
  final bool hasNextPage;
  final bool paginationLoading;
  final bool showScrollButton;

  const SingleConversationState({
    this.scrollController,
    this.images = const [],
    this.messageController,
    this.hasNextPag = false,
    this.messages = const [],
    this.sendMessageApiStatus = ApiStatus.initial,
    this.overAllApiStatus = ApiStatus.loading,
    this.conversationRequest = const ConversationRequest(
      previousRoute: '',
      phoneNumber: '',
      message: '',
      product: ProductMessage(),
      userId: 0,
      userName: '',
      type: SmsType.buyer,
    ),
    this.page = 1,
    this.hasNextPage = false,
    this.paginationLoading = false,
    this.showScrollButton = false,
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
    scrollController,
    page,
    hasNextPage,
    paginationLoading,
    showScrollButton,
  ];

  SingleConversationState copyWith({
    ScrollController? scrollController,
    List<File>? images,
    TextEditingController? messageController,
    bool? hasNextPag,
    List<MessageResponse>? messages,
    ConversationRequest? conversationRequest,
    ApiStatus? overAllApiStatus,
    ApiStatus? sendMessageApiStatus,
    int? page,
    bool? hasNextPage,
    bool? paginationLoading,
    bool? showScrollButton,
  }) {
    return SingleConversationState(
      scrollController: scrollController ?? this.scrollController,
      images: images ?? this.images,
      messageController: messageController ?? this.messageController,
      messages: messages ?? this.messages,
      hasNextPag: hasNextPag ?? this.hasNextPag,
      conversationRequest: conversationRequest ?? this.conversationRequest,
      overAllApiStatus: overAllApiStatus ?? this.overAllApiStatus,
      sendMessageApiStatus: sendMessageApiStatus ?? this.sendMessageApiStatus,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      paginationLoading: paginationLoading ?? this.paginationLoading,
      showScrollButton: showScrollButton ?? this.showScrollButton,
    );
  }
}
