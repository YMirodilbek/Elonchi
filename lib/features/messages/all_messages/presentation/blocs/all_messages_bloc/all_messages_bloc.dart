import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/messages/all_messages/data/chat_list_response.dart';
import 'package:elonchi/features/messages/all_messages/domain/repository/all_massages_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_messages_event.dart';
part 'all_messages_state.dart';

class AllMessagesBloc extends Bloc<AllMessagesEvent, AllMessagesState> {
  final MessagesRepo repo;
  AllMessagesBloc(this.repo) : super(AllMessagesState(index: 0)) {
    on<ChangeMainIndex>(_onChangeMainIndex);
    on<GetConversationsEvent>(onGetConversations);
    on<ToggleDeletingEvent>(onToggleDelete);
    on<DeleteConversationEvent>(onDeleteMessage);
  }

  void _onChangeMainIndex(ChangeMainIndex event, Emitter<AllMessagesState> emit) {
    emit(state.copyWith(index: event.index));
  }

  void onGetConversations(GetConversationsEvent event, Emitter<AllMessagesState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final conversations = await repo.getChatList(type: event.type);
    if (conversations.ok && conversations.data != null) {
      emit(state.copyWith(conversations: conversations.data!.results, apiStatus: ApiStatus.success));
    }
  }

  void onToggleDelete(ToggleDeletingEvent event, Emitter<AllMessagesState> emit) {
    emit(state.copyWith(deleting: !state.deleting));
  }

  void onDeleteMessage(DeleteConversationEvent event, Emitter<AllMessagesState> emit) async {
    emit(state.copyWith(deleteMessageApiStatus: ApiStatus.loading));
    final result = await repo.deleteChat(chatId: event.conversationId);
    if (result.ok) {
      final conversations = List<ChatRoomResponse>.from(state.conversations)
        ..removeWhere((element) => element.id == event.conversationId);
      emit(state.copyWith(conversations: conversations, deleteMessageApiStatus: ApiStatus.success));
    } else {
      emit(state.copyWith(deleteMessageApiStatus: ApiStatus.error));
    }
  }
}
