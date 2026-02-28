import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/features/home/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:elonchi/features/home/presentation/widgets/banner_sheet.dart';
import 'package:elonchi/features/home/presentation/widgets/home_banner.dart';
import 'package:elonchi/features/home/presentation/widgets/banner_shimmer.dart';
import 'package:elonchi/features/home/presentation/widgets/category_shimmer.dart';
import 'package:elonchi/features/home/presentation/widgets/product_grid_shimmer.dart';
import 'package:elonchi/core/widgets/product_item.dart';
import 'package:elonchi/features/home/presentation/widgets/search_widget.dart';
import 'package:elonchi/features/home/presentation/widgets/top_details.dart';
import 'package:elonchi/features/regions/data/regions_response.dart';
import 'package:elonchi/features/regions/presentation/bloc/regions_bloc.dart';
import 'package:elonchi/features/regions/presentation/pages/regions.dart';
import 'package:elonchi/injector_container.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:elonchi/features/home/presentation/widgets/category_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<HomeBloc>();
    bloc.add(const GetCategoriesEvent());
    bloc.add(const GetBannerDataEvent());
    bloc.add(const GetRecentItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(const GetCategoriesEvent());
                bloc.add(const GetBannerDataEvent());
                bloc.add(const GetRecentItems());
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: ListView(
                cacheExtent: 1000,
                padding: const EdgeInsets.all(16),
                children: [
                  TopDetailsHome(
                    onLocationTap: () async {
                      final data = await triggerBottomSheet<RegionResponse>(
                        content: BlocProvider(create: (context) => sl<RegionsBloc>(), child: RegionsSheet()),
                      );
                      if (data != null) {
                        bloc.add(ChangeAdressEvent(region: data));
                      }
                    },
                    adress: state.region?.name ?? "home.select_region".tr(),
                    onLikedTap: () {
                      context.push(Routes.myWishes);
                    },
                    onHotSalesTap: () {
                      context.push(Routes.salesScreen);
                    },
                  ),
                  const SizedBox(height: 16),
                  SearchWidget(
                    onTap: () {
                      context.push(Routes.searchScreen, extra: {"region": state.region});
                    },
                  ),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state.bannerApiStatus == ApiStatus.loading
                        ? BannerShimmer(key: const ValueKey('bannerShimmer'))
                        : state.bannerData.isNotEmpty
                        ? HomeBanner(
                            key: const ValueKey('banner'),
                            banners: state.bannerData,
                            onTap: () {
                              showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => BannerSheet(banners: state.bannerData),
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state.categoriesApiStatus == ApiStatus.loading
                        ? CategoryShimmer(key: const ValueKey('categoryShimmer'))
                        : state.categories.isNotEmpty
                        ? GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              final category = state.categories.length > index ? state.categories[index] : null;
                              return CategoryItem(
                                onTap: () {
                                  context.push(
                                    Routes.searchScreen,
                                    extra: {"region": state.region, "category": category},
                                  );
                                },
                                title: category?.name ?? "home.filters.category".tr(),
                                imagePath: category?.img ?? "",
                              );
                            },
                            itemCount: state.categories.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 12),
                  if (state.recentProductsApiStatus != ApiStatus.loading && state.recentProducts.isNotEmpty)
                    Text("home.recent_products".tr(), style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state.recentProductsApiStatus == ApiStatus.loading
                        ? ProductGridShimmer(key: const ValueKey('recentProductsShimmer'), itemCount: 4)
                        : state.recentProducts.isNotEmpty
                        ? GridView.builder(
                            key: const ValueKey('recentProducts'),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.70,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: state.recentProducts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final product = state.recentProducts[index];
                              final imageUrl = (product.image?.isNotEmpty ?? false)
                                  ? product.image!.first.image ?? ""
                                  : "";
                              return ProductItem(
                                regionName: product.region?.name ?? "",
                                createdAt: product.createdAt,
                                itemId: product.id ?? 0,
                                onLikedTap: () {
                                  if (state.likingStatus == ApiStatus.loading) return;
                                  bloc.add(ToggleLikeEvent(product.id ?? 0));
                                },
                                productImagePath: imageUrl,
                                title: product.price ?? "-",
                                liked: product.iLike ?? false,
                                description: product.title ?? "-",
                              );
                            },
                          )
                        : const SizedBox.shrink(),
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
