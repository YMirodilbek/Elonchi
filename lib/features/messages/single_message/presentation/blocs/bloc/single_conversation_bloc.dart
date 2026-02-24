import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/messages/all_messages/data/chat_list_response.dart';
import 'package:elonchi/features/messages/all_messages/data/conversation_response.dart';
import 'package:elonchi/features/messages/all_messages/domain/repository/all_massages_repo.dart';
import 'package:elonchi/features/messages/single_message/domain/entities/conversation_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'single_conversation_event.dart';
part 'single_conversation_state.dart';

class SingleConversationBloc extends Bloc<SingleConversationEvent, SingleConversationState> {
  final MessagesRepo repo;
  SingleConversationBloc(this.repo) : super(SingleConversationState()) {
    on<InitConversationEvent>(onInitConversation);
    on<GetMessagesEvent>(onGetMessages);
  }

  void onInitConversation(InitConversationEvent event, Emitter<SingleConversationState> emit) async {
    final chatId = event.conversationRequest.chatId;
    if (chatId != null) {
      add(GetMessagesEvent(chatId));
    } else {
      // if its from single screen, I send the message then get .
      final conversationId = await onCreateRoom(event.conversationRequest);
      emit(state.copyWith(conversationRequest: event.conversationRequest.copyWith(chatId: conversationId)));
      add(GetMessagesEvent(conversationId));
    }
  }

  Future<int> onCreateRoom(ConversationRequest request) async {
    final result = await repo.createRoom(
      userId: request.userId,
      productId: request.product.id ?? 0,
      type: request.type,
    );
    return result.data ?? 0;
  }

  void onSendMessage(SendMessageEvent event, Emitter<SingleConversationState> emit) async {
    // final result = await repo.sendMessage(
    // id:  event.conversationRequest.itemId
    // );
    // if (result.ok) {}
  }

  void onGetMessages(GetMessagesEvent event, Emitter<SingleConversationState> emit) async {
    final result = await repo.getChatMessages(chatId: event.chatId);
    if (result.ok && result.data != null) {
      emit(
        state.copyWith(
          messages: result.data!.results,
          hasNextPag: result.data?.next != null,
          overAllApiStatus: ApiStatus.initial,
        ),
      );
    }
  }
}
