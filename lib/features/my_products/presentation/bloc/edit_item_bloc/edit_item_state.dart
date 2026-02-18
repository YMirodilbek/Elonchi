part of 'edit_item_bloc.dart';

class EditItemState extends Equatable {
  final ProductResponse? productResponse;
  final EditItemRequest? editItemRequest;
  final ApiStatus apiStatus;
  final SellMethod sellMethod;

  const EditItemState({
    this.editItemRequest,
    this.apiStatus = ApiStatus.initial,
    this.sellMethod = SellMethod.price,
    this.productResponse,
  });

  @override
  List<Object?> get props => [editItemRequest, apiStatus, sellMethod, productResponse];

  EditItemState copyWith({
    EditItemRequest? editItemRequest,
    ApiStatus? apiStatus,
    SellMethod? sellMethod,
    ProductResponse? productResponse,
  }) {
    return EditItemState(
      productResponse: productResponse ?? this.productResponse,
      sellMethod: sellMethod ?? this.sellMethod,
      editItemRequest: editItemRequest ?? this.editItemRequest,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }
}
