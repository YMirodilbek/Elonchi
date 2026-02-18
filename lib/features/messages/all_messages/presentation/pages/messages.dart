import 'package:elonchi/features/messages/all_messages/presentation/blocs/all_messages_bloc/all_messages_bloc.dart';
import 'package:elonchi/features/messages/all_messages/presentation/widgets/delete_dialog.dart';
import 'package:elonchi/features/messages/all_messages/presentation/widgets/message_item.dart';
import 'package:elonchi/features/messages/all_messages/presentation/widgets/messages_appbar.dart';
import 'package:elonchi/features/messages/all_messages/presentation/widgets/slider_tabs.dart' show SliderTabs;
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllMessagesBloc, AllMessagesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MessagesAppbar(
            deleting: false,
            onTap: () {
              showDialog(context: context, builder: (context) => const DeleteDialog());
            },
          ),
          body: Padding(
            padding: const EdgeInsetsGeometry.all(16),
            child: Column(
              children: [
                SliderTabs(
                  value: state.index,
                  onChaged: (val) {
                    bloc.add(ChangeMainIndex(index: val));
                  },
                ),
                const SizedBox(height: 16),
                MessageStartItem(
                  deleting: false,
                  userName: "TestName",
                  itemName: 'testItem',
                  lastMessage: "you: somth",
                  time: "11:02",
                  onTap: () {
                    context.push(Routes.conversationScreen);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
