part of 'all_messages_bloc.dart';

class AllMessagesState extends Equatable {
  final ApiStatus apiStatus;
  final ApiStatus deleteMessageApiStatus;
  final List<ChatRoomResponse> conversations;
  final bool deleting;
  final int index;
  const AllMessagesState({
    required this.index,
    this.deleting = false,
    this.conversations = const [],
    this.apiStatus = ApiStatus.loading,
    this.deleteMessageApiStatus = ApiStatus.initial,
  });

  AllMessagesState copyWith({
    bool? deleting,
    int? index,
    List<ChatRoomResponse>? conversations,
    ApiStatus? apiStatus,
    ApiStatus? deleteMessageApiStatus,
  }) {
    return AllMessagesState(
      deleting: deleting ?? this.deleting,
      index: index ?? this.index,
      conversations: conversations ?? this.conversations,
      apiStatus: apiStatus ?? this.apiStatus,
      deleteMessageApiStatus: deleteMessageApiStatus ?? this.deleteMessageApiStatus,
    );
  }

  @override
  List<Object> get props => [index, conversations, apiStatus, deleteMessageApiStatus, deleting];
}
