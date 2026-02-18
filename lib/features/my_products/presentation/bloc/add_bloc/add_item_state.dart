part of 'add_item_bloc.dart';

class AddItemState extends Equatable {
  final CreateProductRequest? newProduct;
  final PageController? pageController;
  final double currentPage;
  final SellMethod sellMethod;
  final List<ModelItem> models;

  final ApiStatus apiStatus;
  final String? validationError;

  const AddItemState({
    this.apiStatus = ApiStatus.initial,
    this.models = const [],
    this.newProduct,
    this.pageController,
    this.currentPage = 0.0,
    this.sellMethod = SellMethod.price,
    this.validationError,
  });

  @override
  List<Object?> get props => [newProduct, currentPage, sellMethod, models, apiStatus, validationError];

  AddItemState copyWith({
    ApiStatus? apistatus,
    CreateProductRequest? newProduct,
    double? currentPage,
    SellMethod? sellmethod,
    List<ModelItem>? models,

    String? validationError,
    bool clearValidationError = false,
  }) {
    return AddItemState(
      apiStatus: apistatus ?? apiStatus,

      models: models ?? this.models,
      sellMethod: sellmethod ?? sellMethod,
      newProduct: newProduct ?? this.newProduct,
      pageController: pageController,
      currentPage: currentPage ?? this.currentPage,
      validationError: clearValidationError ? null : validationError ?? this.validationError,
    );
  }

  double get completionPercentage => (currentPage / 8) * 100;

  double get completionProgress => currentPage / 8;

  int get currentPageNumber => (currentPage.toInt()) + 1;
}
