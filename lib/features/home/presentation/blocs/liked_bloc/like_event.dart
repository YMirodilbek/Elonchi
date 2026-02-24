part of 'like_bloc.dart';

sealed class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

final class ToggleLikeEvent extends LikeEvent {
  final int productId;
  const ToggleLikeEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

final class GetLikedProductsEvent extends LikeEvent {
  const GetLikedProductsEvent();

  @override
  List<Object> get props => [];
}
