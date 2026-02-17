part of 'regions_bloc.dart';

sealed class RegionsEvent extends Equatable {
  const RegionsEvent();
}

final class GetRegionsEvent extends RegionsEvent {
  const GetRegionsEvent();
  @override
  List<Object> get props => [];
}
