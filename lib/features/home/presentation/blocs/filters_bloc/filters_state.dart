part of 'filters_bloc.dart';

class FiltersState extends Equatable {
  final String region;
  final GetProductRequest request;
  const FiltersState({this.request = const GetProductRequest(), this.region = ''});

  @override
  List<Object> get props => [request, region];

  FiltersState copyWith({String? region, GetProductRequest? request}) {
    return FiltersState(region: region ?? this.region, request: request ?? this.request);
  }
}
