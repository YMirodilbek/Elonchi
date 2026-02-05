import 'package:elonchi/features/home/presentation/widgets/product_item.dart';
import 'package:elonchi/features/home/presentation/widgets/search_widget.dart';
import 'package:elonchi/features/home/presentation/widgets/top_details.dart';
import 'package:flutter/material.dart';
import 'package:elonchi/features/home/presentation/widgets/category_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TopDetailsHome(adress: 'Tashkent', onLikedTap: () {}, onHotSalesTap: () {}),
            const SizedBox(height: 16),
            SearchWidget(onTap: () {}),
            const SizedBox(height: 8),
            Image.asset("assets/images/banner.png"),
            const SizedBox(height: 8),
            Row(
              children: [
                CategoryItem(onTap: () {}, title: "Все товары", imagePath: 'assets/images/all_categories.png'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [CategoryItem(onTap: () {}, title: "Электроника", imagePath: 'assets/images/electronics.png')],
            ),
            const SizedBox(height: 12),
            Text("Недавные товары", style: TextStyle(fontSize: 16)),
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
    );
  }
}
