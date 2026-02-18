part of 'my_items_bloc.dart';

sealed class MyItemsEvent extends Equatable {
  const MyItemsEvent();
}

final class GetMyItemsEvent extends MyItemsEvent {
  @override
  List<Object> get props => [];
  const GetMyItemsEvent();
}

final class UpdateItemEvent extends MyItemsEvent {
  final ProductResponse product;
  final int index;

  const UpdateItemEvent({required this.product, required this.index});
  @override
  List<Object> get props => [product, index];
}
