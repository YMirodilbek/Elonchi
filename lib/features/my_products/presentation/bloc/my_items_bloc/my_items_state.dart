part of 'my_items_bloc.dart';

class MyItemsState extends Equatable {
  final List<ProductResponse> items;
  final ApiStatus apiStatus;
  const MyItemsState({this.apiStatus = ApiStatus.initial, this.items = const []});

  @override
  List<Object> get props => [apiStatus, items];

  MyItemsState copyWith({ApiStatus? apiStatus, List<ProductResponse>? items}) {
    return MyItemsState(apiStatus: apiStatus ?? this.apiStatus, items: items ?? this.items);
  }
}
