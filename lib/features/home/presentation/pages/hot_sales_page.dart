import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/home/presentation/blocs/watching_bloc/watching_bloc.dart';
import 'package:elonchi/features/home/presentation/widgets/product_grid_shimmer.dart';
import 'package:elonchi/core/widgets/product_item.dart';
import 'package:elonchi/features/home/presentation/widgets/sales_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HotSalesPage extends StatefulWidget {
  const HotSalesPage({super.key});

  @override
  State<HotSalesPage> createState() => _HotSalesPageState();
}

class _HotSalesPageState extends State<HotSalesPage> {
  late final WatchingBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<WatchingBloc>();
    bloc.add(const GetWatchingProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: WScaleAnimation(
          onTap: () {
            context.pop();
          },
          child: Padding(padding: const EdgeInsets.all(11.0), child: SvgPicture.asset(PIcons.arrowLeftIcon)),
        ),
        title: Text(
          'Отслеживать цену',
          style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocBuilder<WatchingBloc, WatchingState>(
        builder: (context, state) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              bloc.add(const GetWatchingProductsEvent());
              await Future.delayed(const Duration(milliseconds: 300));
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.apiStatus == ApiStatus.loading
                  ? ProductGridShimmer(key: const ValueKey('watchingProductsShimmer'), itemCount: 4)
                  : state.products.isEmpty
                  ? ListView(
                      key: const ValueKey('emptyState'),
                      padding: const EdgeInsets.all(16),
                      children: const [
                        SalesEmptyState(),
                        SizedBox(height: 24),
                        Text('Рекомендуем', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                        SizedBox(height: 8),
                      ],
                    )
                  : ListView(
                      key: const ValueKey('productsList'),
                      padding: const EdgeInsets.all(16),
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.70,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductItem(
                              itemId: product.id ?? 0,
                              onLikedTap: () {
                                bloc.add(ToggleWatchingEvent(product.id ?? 0));
                              },
                              productImagePath: product.image?.first.image ?? '',
                              title: product.title ?? '',
                              description: product.description ?? '',
                              liked: product.isWatching ?? false,
                              createdAt: product.createdAt,
                              regionName: product.region?.name ?? 'Unknown',
                            );
                          },
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
