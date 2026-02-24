import 'package:elonchi/features/messages/all_messages/data/chat_list_response.dart';
import 'package:elonchi/features/messages/all_messages/domain/repository/all_massages_repo.dart';
import 'package:elonchi/features/messages/all_messages/presentation/blocs/all_messages_bloc/all_messages_bloc.dart';
import 'package:elonchi/features/messages/all_messages/presentation/widgets/delete_dialog.dart';
import 'package:elonchi/features/messages/all_messages/presentation/widgets/message_item.dart';
import 'package:elonchi/features/messages/all_messages/presentation/widgets/messages_list_shimmer.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/messages/all_messages/presentation/widgets/messages_appbar.dart';
import 'package:elonchi/features/messages/all_messages/presentation/widgets/slider_tabs.dart' show SliderTabs;
import 'package:elonchi/features/messages/single_message/domain/entities/conversation_request.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late final AllMessagesBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<AllMessagesBloc>();
    bloc.add(GetConversationsEvent(type: SmsType.buyer));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllMessagesBloc, AllMessagesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MessagesAppbar(
            deleting: state.deleting,
            onTap: () {
              bloc.add(ToggleDeletingEvent());
            },
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SliderTabs(
                  value: state.index,
                  onChaged: (val) {
                    bloc.add(ChangeMainIndex(index: val));
                    final type = val == 0 ? SmsType.buyer : SmsType.seller;
                    bloc.add(GetConversationsEvent(type: type));
                  },
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: state.apiStatus == ApiStatus.loading
                      ? const MessagesListShimmer(key: ValueKey('shimmer'))
                      : state.apiStatus == ApiStatus.error
                      ? const Center(key: ValueKey('error'), child: Text('Failed to load conversations'))
                      : state.conversations.isEmpty
                      ? const Center(key: ValueKey('empty'), child: Text('No conversations yet'))
                      : RefreshIndicator.adaptive(
                          key: const ValueKey('list'),
                          onRefresh: () async {
                            final type = state.index == 0 ? SmsType.buyer : SmsType.seller;
                            bloc.add(GetConversationsEvent(type: type));
                            await Future.delayed(const Duration(milliseconds: 500));
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: state.conversations.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final chatRoom = state.conversations[index];
                              return MessageStartItem(
                                chatRoom: chatRoom,
                                deleting: state.deleting,
                                onTap: () {
                                  final request = ConversationRequest(
                                    product: chatRoom.product ?? ProductMessage(),
                                    chatId: chatRoom.id ?? 0,
                                    type: SmsType.buyer,
                                    userName: '',
                                    message: '',
                                    userId: 0,
                                  );

                                  context.push(Routes.conversationScreen, extra: request);
                                },
                                onDelete: () async {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => const DeleteDialog(),
                                  );
                                  if (result != null && result) {
                                    bloc.add(DeleteConversationEvent(conversationId: chatRoom.id ?? 0));
                                  }
                                },
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
