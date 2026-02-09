import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/features/home/presentation/widgets/product_item.dart';
import 'package:elonchi/features/home/presentation/widgets/search_selected_cats.dart';
import 'package:elonchi/features/home/presentation/widgets/search_top_part.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              SearchTopPart(
                onBackTap: () {
                  context.pop();
                },
                onDeleteTap: () {},
                onFiltersTap: () {
                  context.push(Routes.filtersScreen);
                },
              ),
              const SizedBox(height: 16),
              const SearchSelectedCategories(),
              const SizedBox(height: 16),
              Row(
                children: [
                  SvgPicture.asset(PIcons.locationIcon),
                  const SizedBox(width: 4),
                  Text(
                    'Toshkent',
                    style: TextStyle(color: context.color.textSub, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text('Найдено (120)', style: TextStyle(color: context.color.textSoft)),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ProductItem(
                            productImagePath: "assets/images/item_1.png",
                            title: "500 000 сум",
                            liked: false,
                            description: "Apple magic mishka",
                          ),
                        ),
                        Expanded(
                          child: ProductItem(
                            productImagePath: "assets/images/item_2.png",
                            title: "1 200 000 сум",
                            liked: false,
                            description: "Magnitlik Shaxmat",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ProductItem(
                            productImagePath: "assets/images/item_1.png",
                            title: "500 000 сум",
                            liked: false,
                            description: "Apple magic mishka",
                          ),
                        ),
                        Expanded(
                          child: ProductItem(
                            productImagePath: "assets/images/item_2.png",
                            title: "1 200 000 сум",
                            liked: false,
                            description: "Magnitlik Shaxmat",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ProductItem(
                            productImagePath: "assets/images/item_1.png",
                            title: "500 000 сум",
                            liked: false,
                            description: "Apple magic mishka",
                          ),
                        ),
                        Expanded(
                          child: ProductItem(
                            productImagePath: "assets/images/item_2.png",
                            title: "1 200 000 сум",
                            liked: false,
                            description: "Magnitlik Shaxmat",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ProductItem(
                            productImagePath: "assets/images/item_1.png",
                            title: "500 000 сум",
                            liked: false,
                            description: "Apple magic mishka",
                          ),
                        ),
                        Expanded(
                          child: ProductItem(
                            productImagePath: "assets/images/item_2.png",
                            title: "1 200 000 сум",
                            liked: false,
                            description: "Magnitlik Shaxmat",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
