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
