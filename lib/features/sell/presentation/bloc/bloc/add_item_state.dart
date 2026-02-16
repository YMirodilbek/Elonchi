part of 'add_item_bloc.dart';

class AddItemState extends Equatable {
  final CreateProductRequest? newProduct;
  final PageController? pageController;

  final double currentPage;

  const AddItemState({this.newProduct, this.pageController, this.currentPage = 0.0});

  @override
  List<Object?> get props => [newProduct, currentPage];

  AddItemState copyWith({CreateProductRequest? newProduct, double? currentPage}) {
    return AddItemState(
      newProduct: newProduct ?? this.newProduct,
      pageController: pageController,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  double get completionPercentage => (currentPage / 8) * 100;

  double get completionProgress => currentPage / 8;

  int get currentPageNumber => (currentPage.toInt()) + 1;
}
