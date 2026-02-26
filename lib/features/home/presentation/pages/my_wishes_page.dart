import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/home/presentation/blocs/liked_bloc/like_bloc.dart';
import 'package:elonchi/features/home/presentation/widgets/empty_state.dart';
import 'package:elonchi/features/home/presentation/widgets/product_grid_shimmer.dart';
import 'package:elonchi/core/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  late final LikeBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<LikeBloc>();
    bloc.add(const GetLikedProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: WScaleAnimation(
          onTap: () {
            context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: SvgPicture.asset(PIcons.arrowLeftIcon, color: context.color.iconStrong),
          ),
        ),
        title: Text(
          "liked.title".tr(),
          style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocBuilder<LikeBloc, LikeState>(
        builder: (context, state) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              bloc.add(const GetLikedProductsEvent());
              await Future.delayed(const Duration(milliseconds: 300));
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.apiStatus == ApiStatus.loading
                  ? ProductGridShimmer(key: const ValueKey('likedProductsShimmer'), itemCount: 4)
                  : state.products.isEmpty
                  ? ListView(
                      key: const ValueKey('emptyState'),
                      padding: const EdgeInsets.all(16),
                      children: [
                        const LikedEmptyState(),
                        const SizedBox(height: 24),
                        Text("home.recommended".tr(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                        const SizedBox(height: 8),
                      ],
                    )
                  : ListView(
                      key: const ValueKey('productsList'),
                      padding: const EdgeInsets.all(16),
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                bloc.add(ToggleLikeEvent(product.id ?? 0));
                              },
                              productImagePath: product.image?.first.image ?? '',
                              title: product.title ?? '',
                              description: product.description ?? '',
                              liked: product.iLike ?? true,
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
