import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/my_products/data/edit_item_request.dart';
import 'package:elonchi/features/my_products/data/product_item_response.dart';
import 'package:elonchi/features/my_products/domain/entities/sell_method.dart';
import 'package:elonchi/features/my_products/presentation/bloc/edit_item_bloc/edit_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EditItemPage extends StatefulWidget {
  final ProductResponse product;
  const EditItemPage({super.key, required this.product});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late final TextEditingController controller;
  late final EditItemBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<EditItemBloc>();
    controller = TextEditingController(text: widget.product.price);
    bloc.add(
      InitDataEvent(
        EditItemRequest(
          id: widget.product.id ?? 0,
          price: int.tryParse(widget.product.price ?? "0") ?? 0,
          moneyType: widget.product.moneyType,
          trade: widget.product.trade,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EditItemBloc, EditItemState>(
        listener: (context, state) {
          if (state.apiStatus == ApiStatus.success) {
            context.pop(state.productResponse);
          }
        },
        child: BlocBuilder<EditItemBloc, EditItemState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            context.pop();
                          },
                          child: SizedBox(height: 24, width: 24, child: SvgPicture.asset(PIcons.arrowLeftIcon)),
                        ),
                        const Spacer(),
                        WScaleAnimation(
                          onTap: () {
                            context.pop();
                          },
                          child: Text('Закрыть', style: TextStyle(color: context.color.textSoft)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Укажите новую цену",
                      style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Покупатели чаще откликаются на товары со сниженной ценой",
                      style: TextStyle(color: context.color.textSub),
                    ),
                    const SizedBox(height: 24),
                    Text('Условия', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WScaleAnimation(
                          onTap: () {
                            bloc.add(ChangeSellMethod(method: SellMethod.price));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 1, color: context.color.stroke),
                              color: state.sellMethod == SellMethod.price
                                  ? context.color.bgelevation
                                  : context.color.background,
                            ),
                            child: Text('Указать цену', style: TextStyle(color: context.color.textSoft)),
                          ),
                        ),
                        WScaleAnimation(
                          onTap: () {
                            bloc.add(ChangeSellMethod(method: SellMethod.exchange));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            decoration: BoxDecoration(
                              color: state.sellMethod == SellMethod.exchange
                                  ? context.color.bgelevation
                                  : context.color.background,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 1, color: context.color.stroke),
                            ),
                            child: Text('Обмен         ', style: TextStyle(color: context.color.textSoft)),
                          ),
                        ),
                        WScaleAnimation(
                          onTap: () {
                            bloc.add(ChangeSellMethod(method: SellMethod.giveAway));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            decoration: BoxDecoration(
                              color: state.sellMethod == SellMethod.giveAway
                                  ? context.color.bgelevation
                                  : context.color.background,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 1, color: context.color.stroke),
                            ),
                            child: Text('Отдам даром', style: TextStyle(color: context.color.textSoft)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    if (state.sellMethod == SellMethod.price)
                      Text('Цена', style: TextStyle(color: context.color.textStrong)),
                    if (state.sellMethod == SellMethod.price) const SizedBox(height: 8),
                    if (state.sellMethod == SellMethod.price)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 1, color: context.color.stroke),
                                color: context.color.bgelevation,
                              ),
                              child: TextField(
                                controller: controller,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  bloc.add(ChangePriceEvent(value));
                                  //
                                },
                                decoration: InputDecoration(
                                  contentPadding: .symmetric(horizontal: 12, vertical: 16),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          WScaleAnimation(
                            onTap: () {
                              bloc.add(ChangeMoneyTypeEvent(value: "UZS"));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 1, color: context.color.stroke),
                                color: state.editItemRequest?.moneyType == "UZS"
                                    ? context.color.bgelevation
                                    : context.color.background,
                              ),
                              child: Text('Сум', style: TextStyle(color: context.color.textStrong)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          WScaleAnimation(
                            onTap: () {
                              bloc.add(ChangeMoneyTypeEvent(value: "USD"));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 1, color: context.color.stroke),
                                color: state.editItemRequest?.moneyType == "USD"
                                    ? context.color.bgelevation
                                    : context.color.background,
                              ),
                              child: Text('\$', style: TextStyle(color: context.color.textStrong)),
                            ),
                          ),
                        ],
                      ),
                    if (state.sellMethod == SellMethod.price)
                      Container(
                        margin: .only(top: 32),
                        padding: .all(16),
                        decoration: BoxDecoration(
                          borderRadius: .circular(12),
                          border: Border.all(width: 1, color: context.color.stroke),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/sales.png', height: 27),
                            const SizedBox(width: 16),
                            Text('Можно торговаться', style: TextStyle(color: context.color.textStrong)),
                            Spacer(),
                            Switch(
                              value: state.editItemRequest?.trade ?? false,
                              onChanged: (val) {
                                bloc.add(ChangeTradeEvent(val));
                              },
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    ButtonWithScale(
                      isLoading: state.apiStatus == ApiStatus.loading,
                      onPressed: () {
                        bloc.add(const EditItemRequestEvent());
                      },
                      color: context.color.base,
                      child: Text(
                        'Сохранить',
                        style: TextStyle(color: context.color.white, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
