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
  const SendMessageEvent();
  @override
  List<Object> get props => [];
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

final class AddImageToMessageEvent extends SingleConversationEvent {
  const AddImageToMessageEvent();

  @override
  List<Object> get props => [];
}

final class DeleteImageEvent extends SingleConversationEvent {
  final int index;
  const DeleteImageEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class LaunchPhoneNumber extends SingleConversationEvent {
  const LaunchPhoneNumber();

  @override
  List<Object> get props => [];
}

final class LoadMoreMessagesEvent extends SingleConversationEvent {
  const LoadMoreMessagesEvent();

  @override
  List<Object> get props => [];
}

final class ScrollPositionChangedEvent extends SingleConversationEvent {
  final double offset;
  const ScrollPositionChangedEvent(this.offset);

  @override
  List<Object> get props => [offset];
}

final class ScrollToBottomEvent extends SingleConversationEvent {
  const ScrollToBottomEvent();

  @override
  List<Object> get props => [];
}
