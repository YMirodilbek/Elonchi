import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/features/messages/single_message/domain/entities/conversation_request.dart';
import 'package:elonchi/features/messages/single_message/presentation/blocs/bloc/single_conversation_bloc.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/chat_textfield.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/conversation_appbar.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/options_sheet.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/received_message.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/related_item.dart';
import 'package:elonchi/features/report/presentation/pages/report_sheet.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/message_date_separator.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/sent_message.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ConversationPage extends StatefulWidget {
  final ConversationRequest conversationRequest;
  const ConversationPage({super.key, required this.conversationRequest});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late final SingleConversationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<SingleConversationBloc>();
    bloc.add(InitConversationEvent(widget.conversationRequest));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleConversationBloc, SingleConversationState>(
      builder: (context, state) {
        final relatedProduct = state.conversationRequest.product;
        return Scaffold(
          appBar: ConversationAppbar(
            imageUrl: state.conversationRequest.imageUrl,
            userName: state.conversationRequest.userName,
            onCallTap: () {
              bloc.add(const LaunchPhoneNumber());
            },
            onThreeDotsTap: () async {
              final choice = await triggerBottomSheet<String>(
                content: OptionsSheet(
                  onDeleteTap: () {},
                  onReportTap: () {
                    context.pop('report');
                  },
                ),
              );
              if (choice == "report") {
                triggerBottomSheet(content: ReportSheet(productId: 0));
              }
            },
          ),
          body: Column(
            children: [
              Container(
                height: 16,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: context.color.base200)),
                ),
              ),
              RelatedItem(
                imagePath: relatedProduct.image ?? "",
                itemName: relatedProduct.title ?? "",
                itemPrice: "${relatedProduct.price} ${relatedProduct.moneyType}",
                onTap: () {
                  if (state.conversationRequest.previousRoute.isEmpty) {
                    return;
                  }
                  if (state.conversationRequest.previousRoute == 'singleItem') {
                    context.pop();
                  } else {
                    context.push(Routes.singleItemScreen, extra: relatedProduct.id);
                  }
                },
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView.separated(
                      controller: state.scrollController,
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      reverse: true,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 120);
                        }

                        // Pagination loader at the end
                        if (state.paginationLoading && index == state.messages.length) {
                          return const Center(child: CupertinoActivityIndicator(radius: 10));
                        }

                        final messageIndex = index - 1;
                        final message = state.messages[messageIndex];
                        bool showDate = false;
                        if (messageIndex == state.messages.length - 1) {
                          showDate = true;
                        } else {
                          final nextMessage = state.messages[messageIndex + 1];
                          final messageDate = DateTime.parse(message.timestamp ?? '');
                          final nextDate = DateTime.parse(nextMessage.timestamp ?? '');
                          showDate =
                              messageDate.day != nextDate.day ||
                              messageDate.month != nextDate.month ||
                              messageDate.year != nextDate.year;
                        }
                        return Column(
                          children: [
                            if (showDate)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: MessageDateSeparator(timestamp: message.timestamp ?? ''),
                              ),
                            if (message.i == true)
                              SentMessage(
                                message: message.content ?? '',
                                read: true,
                                time: _formatTime(message.timestamp),
                                imageUrl: message.image,
                              )
                            else
                              ReceivedMessage(
                                message: message.content ?? '',
                                time: _formatTime(message.timestamp),
                                imageUrl: message.image,
                              ),
                          ],
                        );
                      },
                      itemCount: state.messages.length + 1 + (state.paginationLoading ? 1 : 0),
                    ),
                    // Scroll to bottom button
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: state.showScrollButton
                            ? GestureDetector(
                                onTap: () => bloc.add(const ScrollToBottomEvent()),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                                  ),
                                  child: const Icon(Icons.keyboard_arrow_down, size: 24),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomSheet: ChatInputField(
            onImageRemoveTap: () {
              bloc.add(const DeleteImageEvent(0));
            },
            imageFile: state.images.isNotEmpty ? state.images.last : null,
            onImageAddTap: () {
              bloc.add(const AddImageToMessageEvent());
            },
            controller: state.messageController,
            onSend: () {
              bloc.add(const SendMessageEvent());
            },
            enabled: state.sendMessageApiStatus != ApiStatus.loading,
            hint: "Написать собщения",
          ),
        );
      },
    );
  }

  String _formatTime(String? timestamp) {
    if (timestamp == null) return '';
    try {
      final dateTime = DateTime.parse(timestamp);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }
}
