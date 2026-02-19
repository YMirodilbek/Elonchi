import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/categories/presentation/blocs/bloc/category_bloc.dart';
import 'package:elonchi/features/categories/presentation/pages/categories_page.dart';
import 'package:elonchi/features/home/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:elonchi/features/home/presentation/widgets/product_item.dart';
import 'package:elonchi/features/home/presentation/widgets/search_selected_cats.dart';
import 'package:elonchi/features/home/presentation/widgets/search_top_part.dart';
import 'package:elonchi/features/regions/data/regions_response.dart';
import 'package:elonchi/features/regions/presentation/bloc/regions_bloc.dart';
import 'package:elonchi/features/regions/presentation/pages/regions.dart';
import 'package:elonchi/injector_container.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  final RegionResponse? region;
  final CategoryResponse? category;
  const SearchPage({super.key, this.region, this.category});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<SearchBloc>();
    bloc.add(InitController(TextEditingController()));
    if (widget.category != null) {
      bloc.add(SetCategoryEvent(widget.category!));
    }
    if (widget.region != null) {
      bloc.add(SetRegionEvent(widget.region!));
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      bloc.add(const GetProducts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  SearchTopPart(
                    searchController: state.searchController,
                    onSearch: (value) {
                      if (value.trim().isEmpty) return;
                      bloc.add(SearchProductsEvent(value));
                    },
                    showDeleteIcon: state.request.query?.isNotEmpty == true,
                    onBackTap: () {
                      context.pop();
                    },
                    onDeleteTap: () {
                      bloc.add(const DeleteQueryEvent());
                    },
                    onFiltersTap: () {
                      context.push(Routes.filtersScreen, extra: state.request);
                    },
                  ),
                  const SizedBox(height: 16),
                  SearchSelectedCategories(
                    onCategoryTap: () {
                      triggerBottomSheet(
                        content: BlocProvider(create: (context) => sl<CategoryBloc>(), child: CategoriesPage()),
                      );
                    },
                    categoryName: state.category?.name,
                  ),
                  const SizedBox(height: 16),
                  WScaleAnimation(
                    onTap: () async {
                      final data = await triggerBottomSheet<RegionResponse>(
                        content: BlocProvider(create: (context) => sl<RegionsBloc>(), child: RegionsSheet()),
                      );
                      if (data != null) {
                        bloc.add(SetRegionEvent(data));
                        Future.delayed(const Duration(milliseconds: 500), () {
                          bloc.add(const GetProducts());
                        });
                      }
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(PIcons.locationIcon),
                        const SizedBox(width: 4),
                        Text(
                          state.region?.name ?? 'Выберите регион',
                          style: TextStyle(color: context.color.textSub, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text('Найдено (${state.products.length})', style: TextStyle(color: context.color.textSoft)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: state.products.isEmpty
                        ? Center(
                            child: Text('Товаров не найдено', style: TextStyle(color: context.color.textSoft)),
                          )
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 8,
                            ),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              final imageUrl = (product.image?.isNotEmpty ?? false)
                                  ? product.image!.first.image ?? "assets/images/item_1.png"
                                  : "assets/images/item_1.png";
                              return ProductItem(
                                onLikedTap: () {},
                                productImagePath: imageUrl,
                                title: product.price ?? "N/A",
                                liked: false,
                                description: product.title ?? "N/A",
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
