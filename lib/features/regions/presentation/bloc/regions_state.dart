part of 'regions_bloc.dart';

class RegionsState extends Equatable {
  final List<RegionResponse> regions;
  final ApiStatus apiStatus;
  const RegionsState({this.regions = const [], this.apiStatus = ApiStatus.initial});

  @override
  List<Object> get props => [regions];

  RegionsState copyWith({List<RegionResponse>? regions, ApiStatus? apiStatus}) {
    return RegionsState(regions: regions ?? this.regions, apiStatus: apiStatus ?? this.apiStatus);
  }
}
