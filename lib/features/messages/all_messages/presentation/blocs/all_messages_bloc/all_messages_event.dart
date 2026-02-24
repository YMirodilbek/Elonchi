part of 'all_messages_bloc.dart';

sealed class AllMessagesEvent extends Equatable {
  const AllMessagesEvent();
}

final class ChangeMainIndex extends AllMessagesEvent {
  final int index;
  const ChangeMainIndex({required this.index});

  @override
  List<Object> get props => [index];
}

final class GetConversationsEvent extends AllMessagesEvent {
  final SmsType type;
  const GetConversationsEvent({required this.type});

  @override
  List<Object> get props => [type];
}

final class ToggleDeletingEvent extends AllMessagesEvent {
  const ToggleDeletingEvent();

  @override
  List<Object> get props => [];
}

final class DeleteConversationEvent extends AllMessagesEvent {
  final int conversationId;
  const DeleteConversationEvent({required this.conversationId});

  @override
  List<Object> get props => [conversationId];
}
