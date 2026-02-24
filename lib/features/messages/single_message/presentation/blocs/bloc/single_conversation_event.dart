part of 'single_conversation_bloc.dart';

sealed class SingleConversationEvent extends Equatable {
  const SingleConversationEvent();

  @override
  List<Object> get props => [];
}

final class InitConversationEvent extends SingleConversationEvent {
  final ConversationRequest conversationRequest;
  const InitConversationEvent(this.conversationRequest);
  @override
  List<Object> get props => [conversationRequest];
}

final class SendMessageEvent extends SingleConversationEvent {
  final String message;
  const SendMessageEvent(this.message);
  @override
  List<Object> get props => [message];
}

final class GetMessagesEvent extends SingleConversationEvent {
  final int chatId;
  const GetMessagesEvent(this.chatId);
  @override
  List<Object> get props => [chatId];
}

final class CreateRoomEvent extends SingleConversationEvent {
  final ConversationRequest request;
  const CreateRoomEvent(this.request);

  @override
  List<Object> get props => [request];
}
