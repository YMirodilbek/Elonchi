part of 'watching_bloc.dart';

class WatchingState extends Equatable {
  final ApiStatus status;

  const WatchingState({this.status = ApiStatus.initial});

  @override
  List<Object> get props => [status];

  WatchingState copyWith({ApiStatus? status}) {
    return WatchingState(status: status ?? this.status);
  }
}
