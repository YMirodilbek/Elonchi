import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/features/home/presentation/blocs/home_bloc/home_bloc.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: ListView(
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
                  adress: state.region?.name ?? "Выберите регион",
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
                Image.asset("assets/images/banner.png"),
                const SizedBox(height: 8),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final category = state.categories.length > index ? state.categories[index] : null;
                    return CategoryItem(
                      onTap: () {
                        context.push(Routes.searchScreen, extra: {"region": state.region, "category": category});
                      },
                      title: category?.name ?? "Категория",
                      imagePath: category?.img ?? "",
                    );
                  },
                  itemCount: state.categories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                const SizedBox(height: 12),
                Text("Недавные товары", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                // Row(
                //   children: [
                //     Expanded(
                //       child: ProductItem(
                //         productImagePath: "assets/images/item_1.png",
                //         title: "500 000 сум",
                //         liked: false,
                //         description: "Apple magic mishka",
                //       ),
                //     ),
                //     Expanded(
                //       child: ProductItem(
                //         productImagePath: "assets/images/item_2.png",
                //         title: "1 200 000 сум",
                //         liked: false,
                //         description: "Magnitlik Shaxmat",
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 8),
                // Row(
                //   children: [
                //     Expanded(
                //       child: ProductItem(
                //         productImagePath: "assets/images/item_1.png",
                //         title: "500 000 сум",
                //         liked: false,
                //         description: "Apple magic mishka",
                //       ),
                //     ),
                //     Expanded(
                //       child: ProductItem(
                //         productImagePath: "assets/images/item_2.png",
                //         title: "1 200 000 сум",
                //         liked: false,
                //         description: "Magnitlik Shaxmat",
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
