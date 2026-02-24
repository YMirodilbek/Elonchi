part of 'like_bloc.dart';

class LikeState extends Equatable {
  final ApiStatus status;
  final List<Product> likedItems;
  const LikeState({this.status = ApiStatus.initial, this.likedItems = const []});

  @override
  List<Object> get props => [status, likedItems];

  LikeState copyWith({ApiStatus? status, List<Product>? likedItems}) {
    return LikeState(status: status ?? this.status, likedItems: likedItems ?? this.likedItems);
  }
}
