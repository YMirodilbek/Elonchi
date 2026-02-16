part of 'add_item_bloc.dart';

sealed class AddItemEvent extends Equatable {
  const AddItemEvent();
}

final class AddImageEvent extends AddItemEvent {
  const AddImageEvent();

  @override
  List<Object> get props => [];
}

final class ImageDeleteEvent extends AddItemEvent {
  final int index;
  const ImageDeleteEvent({required this.index});
  @override
  List<Object> get props => [index];
}

final class NextPageEvent extends AddItemEvent {
  const NextPageEvent();
  @override
  List<Object> get props => [];
}

final class PreviousPageEvent extends AddItemEvent {
  const PreviousPageEvent();
  @override
  List<Object> get props => [];
}

final class ChangeItemTitleEvent extends AddItemEvent {
  final String title;
  const ChangeItemTitleEvent({required this.title});

  @override
  List<Object> get props => [title];
}
