import 'dart:io';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/messages/all_messages/data/chat_list_response.dart';
import 'package:elonchi/features/messages/all_messages/data/conversation_response.dart';
import 'package:elonchi/features/messages/all_messages/data/send_message_request.dart';
import 'package:elonchi/features/messages/all_messages/domain/repository/all_massages_repo.dart';
import 'package:elonchi/features/messages/single_message/domain/entities/conversation_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

part 'single_conversation_event.dart';
part 'single_conversation_state.dart';

class SingleConversationBloc extends Bloc<SingleConversationEvent, SingleConversationState> {
  final MessagesRepo repo;
  SingleConversationBloc(this.repo) : super(SingleConversationState()) {
    on<InitConversationEvent>(onInitConversation);
    on<GetMessagesEvent>(onGetMessages);
    on<SendMessageEvent>(onSendMessage);
    on<AddImageToMessageEvent>(onAddImageToMessage);
    on<DeleteImageEvent>(onDeleteImage);
    on<LaunchPhoneNumber>(onLaunchPhoneNumber);
    on<LoadMoreMessagesEvent>(onLoadMoreMessages);
    on<ScrollPositionChangedEvent>(onScrollPositionChanged);
    on<ScrollToBottomEvent>(onScrollToBottom);
  }

  void onInitConversation(InitConversationEvent event, Emitter<SingleConversationState> emit) async {
    final chatId = event.conversationRequest.chatId;
    final scrollController = ScrollController();

    // Add scroll listener for pagination & show/hide scroll button
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        EasyDebounce.debounce(
          'pagination',
          const Duration(milliseconds: 100),
          () => add(const LoadMoreMessagesEvent()),
        );
      }
      if (scrollController.offset > 300 && !state.showScrollButton) {
        add(const ScrollPositionChangedEvent(301));
      } else if (state.showScrollButton && scrollController.offset < 300) {
        add(const ScrollPositionChangedEvent(0));
      }
    });

    emit(
      state.copyWith(
        conversationRequest: event.conversationRequest,
        messageController: TextEditingController(),
        scrollController: scrollController,
      ),
    );

    if (chatId != null) {
      add(GetMessagesEvent(chatId));
    } else {
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

  void onGetMessages(GetMessagesEvent event, Emitter<SingleConversationState> emit) async {
    final result = await repo.getChatMessages(chatId: event.chatId);
    if (result.ok && result.data != null) {
      emit(
        state.copyWith(
          messages: result.data!.results,
          hasNextPage: result.data?.next != null,
          page: 1,
          overAllApiStatus: ApiStatus.initial,
        ),
      );
    }
  }

  void onLoadMoreMessages(LoadMoreMessagesEvent event, Emitter<SingleConversationState> emit) async {
    if (state.paginationLoading || !state.hasNextPage) return;

    emit(state.copyWith(paginationLoading: true));

    final nextPage = state.page + 1;
    final result = await repo.getChatMessages(chatId: state.conversationRequest.chatId ?? 0, page: nextPage);

    if (result.ok && result.data != null) {
      final updatedMessages = <MessageResponse>[...state.messages, ...result.data!.results ?? []];
      emit(
        state.copyWith(
          messages: updatedMessages,
          page: nextPage,
          hasNextPage: result.data?.next != null,
          paginationLoading: false,
        ),
      );
    } else {
      emit(state.copyWith(paginationLoading: false));
    }
  }

  void onScrollPositionChanged(ScrollPositionChangedEvent event, Emitter<SingleConversationState> emit) {
    emit(state.copyWith(showScrollButton: event.offset > 300));
  }

  void onScrollToBottom(ScrollToBottomEvent event, Emitter<SingleConversationState> emit) {
    if (state.scrollController != null && state.scrollController!.hasClients) {
      state.scrollController!.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void onSendMessage(SendMessageEvent event, Emitter<SingleConversationState> emit) async {
    if (state.messageController?.text.isEmpty == true && state.images.isEmpty) {
      return;
    }
    emit(state.copyWith(sendMessageApiStatus: ApiStatus.loading));
    final result = await repo.sendMessage(
      chatId: state.conversationRequest.chatId ?? 0,
      request: SendMessageRequest(content: state.messageController?.text ?? '', images: state.images),
    );

    if (result.ok && result.data != null) {
      final newMessage = MessageResponse(
        id: result.data!.id,
        i: result.data!.i,
        sender: result.data!.sender != null
            ? SenderResponse(
                id: result.data!.sender!.id,
                phone: result.data!.sender!.phone,
                image: result.data!.sender!.image,
                firstName: result.data!.sender!.firstName,
                lastName: result.data!.sender!.lastName,
                isStaff: result.data!.sender!.isStaff,
                isActive: result.data!.sender!.isActive,
              )
            : null,
        room: result.data!.room,
        image: result.data!.image,
        content: result.data!.content,
        timestamp: result.data!.timestamp,
      );

      final updatedMessages = [newMessage, ...state.messages];
      emit(
        state.copyWith(
          messages: updatedMessages,
          messageController: state.messageController?..clear(),
          images: [],
          sendMessageApiStatus: ApiStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(sendMessageApiStatus: ApiStatus.error));
    }
  }

  void onAddImageToMessage(AddImageToMessageEvent event, Emitter<SingleConversationState> emit) async {
    if (state.images.isNotEmpty) return;

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final originalFile = File(pickedFile.path);
      final originalBytes = await originalFile.length();
      print('Original size: ${(originalBytes / (1024 * 1024)).toStringAsFixed(2)} MB');

      final compressed = await compressFile(originalFile);
      final finalFile = compressed ?? originalFile;

      final compressedBytes = await finalFile.length();
      print('Compressed size: ${(compressedBytes / (1024 * 1024)).toStringAsFixed(2)} MB');

      final updatedImages = List<File>.from(state.images)..add(finalFile);
      emit(state.copyWith(images: updatedImages));
    }
  }

  void onDeleteImage(DeleteImageEvent event, Emitter<SingleConversationState> emit) {
    final updatedImages = List<File>.from(state.images)..removeAt(event.index);
    emit(state.copyWith(images: updatedImages));
  }

  void onLaunchPhoneNumber(LaunchPhoneNumber event, Emitter<SingleConversationState> emit) async {
    await launchUrl(Uri.parse('tel:${state.conversationRequest.phoneNumber}'));
  }

  Future<File?> compressFile(File file) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${file.path}_compressed.jpg',
      quality: 70,
    );
    return result != null ? File(result.path) : null;
  }
}
