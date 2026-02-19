part of 'search_bloc.dart';

class SearchState extends Equatable {
  final TextEditingController? searchController;
  final int pageNum;
  final bool hasNext;
  final List<Product> products;
  final GetProductRequest request;
  final RegionResponse? region;
  final CategoryResponse? category;
  const SearchState({
    this.searchController,
    this.region,
    this.category,
    this.request = const GetProductRequest(),
    this.products = const [],
    this.pageNum = 1,
    this.hasNext = true,
  });

  @override
  List<Object?> get props => [region, category, request, products, hasNext, pageNum, searchController];

  SearchState copyWith({
    TextEditingController? searchController,
    RegionResponse? region,
    CategoryResponse? category,
    GetProductRequest? request,
    List<Product>? products,
    bool? hasNext,
    int? pageNum,
  }) {
    return SearchState(
      searchController: searchController ?? this.searchController,
      pageNum: pageNum ?? this.pageNum,
      region: region ?? this.region,
      category: category ?? this.category,
      request: request ?? this.request,
      products: products ?? this.products,
      hasNext: hasNext ?? this.hasNext,
    );
  }
}
