part of 'all_messages_bloc.dart';

class AllMessagesState extends Equatable {
  final int index;
  const AllMessagesState({required this.index});

  AllMessagesState copyWith({int? index}) {
    return AllMessagesState(index: index ?? this.index);
  }

  @override
  List<Object> get props => [index];
}
