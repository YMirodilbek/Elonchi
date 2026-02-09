import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/features/sell/presentation/widgets/current_item.dart';
import 'package:elonchi/features/sell/presentation/widgets/tabs.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Продать', style: TextStyle(color: context.color.textStrong, fontSize: 20)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SellTabs(),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: [
                CurrentItem(
                  onLowerPriceTap: () {},
                  imagePath: "assets/images/dummy_img2.png",
                  itemPrice: "500 000 сум",
                  itemName: "Atirgul",
                  watchedCount: 1232,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 200,
        child: ButtonWithScale(
          onPressed: () {
            context.push(Routes.addItemScreen);
          },
          color: context.color.base,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: context.color.white),
              const SizedBox(width: 8),
              Text(
                'Разместить товар',
                style: TextStyle(color: context.color.white, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
