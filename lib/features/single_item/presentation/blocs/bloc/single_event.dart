part of 'single_bloc.dart';

sealed class SingleEvent extends Equatable {
  const SingleEvent();
}

class GetSingleItemEvent extends SingleEvent {
  final int itemId;
  const GetSingleItemEvent(this.itemId);
  @override
  List<Object> get props => [itemId];
}

class ToggleFavoriteEvent extends SingleEvent {
  final int itemId;
  const ToggleFavoriteEvent(this.itemId);
  @override
  List<Object> get props => [itemId];
}

class ToggleLikeRecomendedProduct extends SingleEvent {
  final int itemId;
  const ToggleLikeRecomendedProduct(this.itemId);
  @override
  List<Object> get props => [itemId];
}

class WatchProductEvent extends SingleEvent {
  final int itemId;
  const WatchProductEvent(this.itemId);
  @override
  List<Object> get props => [itemId];
}
