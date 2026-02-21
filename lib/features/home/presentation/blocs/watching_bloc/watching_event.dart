part of 'watching_bloc.dart';

sealed class WatchingEvent extends Equatable {
  const WatchingEvent();
}

final class GetWatchingProductsEvent extends WatchingEvent {
  const GetWatchingProductsEvent();

  @override
  List<Object> get props => [];
}
