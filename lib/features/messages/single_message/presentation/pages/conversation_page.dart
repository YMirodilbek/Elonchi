import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/features/messages/single_message/domain/entities/conversation_request.dart';
import 'package:elonchi/features/messages/single_message/presentation/blocs/bloc/single_conversation_bloc.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/chat_textfield.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/conversation_appbar.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/options_sheet.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/received_message.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/related_item.dart';
import 'package:elonchi/features/report/presentation/pages/report_sheet.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/sent_message.dart';
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
        print(relatedProduct.image);
        return Scaffold(
          appBar: ConversationAppbar(
            userName: state.conversationRequest.userName,
            onCallTap: () {},
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
                onTap: () {},
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  reverse: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 120);
                    }
                    if (index % 2 == 0) {
                      return ReceivedMessage(time: "12:05", message: "Test");
                    }
                    return SentMessage(message: "Test", read: true, time: "12:01");
                  },
                  itemCount: 7,
                ),
              ),
            ],
          ),
          bottomSheet: ChatInputField(onSend: () {}, enabled: true, hint: "Написать собщения"),
        );
      },
    );
  }
}
