import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/features/my_products/data/product_item_response.dart';
import 'package:elonchi/features/my_products/presentation/bloc/my_items_bloc/my_items_bloc.dart';
import 'package:elonchi/features/my_products/presentation/widgets/current_item.dart';
import 'package:elonchi/features/my_products/presentation/widgets/tabs.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyItemsPage extends StatefulWidget {
  const MyItemsPage({super.key});

  @override
  State<MyItemsPage> createState() => _MyItemsPageState();
}

class _MyItemsPageState extends State<MyItemsPage> {
  late final MyItemsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<MyItemsBloc>();
    bloc.add(const GetMyItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Продать', style: TextStyle(color: context.color.textStrong, fontSize: 20)),
        centerTitle: false,
      ),
      body: BlocBuilder<MyItemsBloc, MyItemsState>(
        builder: (context, state) {
          return Column(
            children: [
              SellTabs(),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => CurrentItem(
                    onLowerPriceTap: () async {
                      final data = await context.push<ProductResponse>(
                        Routes.editItemScreen,
                        extra: state.items[index],
                      );
                      if (data != null) {
                        bloc.add(UpdateItemEvent(product: data, index: index));
                      }
                    },
                    product: state.items[index],
                  ),
                  itemCount: state.items.length,
                ),
              ),
            ],
          );
        },
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
