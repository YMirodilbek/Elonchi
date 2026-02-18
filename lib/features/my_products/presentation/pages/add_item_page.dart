import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/categories/domain/entities/selected_category.dart';
import 'package:elonchi/features/categories/presentation/blocs/bloc/category_bloc.dart';
import 'package:elonchi/features/categories/presentation/pages/categories_page.dart';
import 'package:elonchi/features/regions/presentation/bloc/regions_bloc.dart';
import 'package:elonchi/features/regions/presentation/pages/regions.dart';
import 'package:elonchi/features/my_products/domain/entities/condition.dart';
import 'package:elonchi/features/my_products/presentation/bloc/add_bloc/add_item_bloc.dart';
import 'package:elonchi/features/my_products/presentation/page_view/add_characteristics.dart';
import 'package:elonchi/features/my_products/presentation/page_view/add_decription.dart';
import 'package:elonchi/features/my_products/presentation/page_view/add_name.dart';
import 'package:elonchi/features/my_products/presentation/page_view/contacts.dart';
import 'package:elonchi/features/my_products/presentation/page_view/image_add.dart';
import 'package:elonchi/features/my_products/presentation/page_view/meet_place.dart';
import 'package:elonchi/features/my_products/presentation/page_view/requirements.dart';
import 'package:elonchi/features/my_products/presentation/page_view/selecte_category.dart';
import 'package:elonchi/features/my_products/presentation/widgets/brands_sheet.dart';
import 'package:elonchi/features/my_products/presentation/widgets/progress_bar.dart';
import 'package:elonchi/injector_container.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late final AddItemBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<AddItemBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddItemBloc, AddItemState>(
      listener: (context, state) {
        if (state.validationError != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.validationError!)));
        }
        if (state.apiStatus == ApiStatus.success) {
          context.pushReplacement(Routes.successItemAddedScreen);
        }
      },
      child: Scaffold(
        body: BlocBuilder<AddItemBloc, AddItemState>(
          builder: (context, state) {
            final List<Widget> forms = [
              ImageAddForm(
                onDeleteImage: (int index) {
                  bloc.add(ImageDeleteEvent(index: index));
                },
                onImagetap: () {
                  bloc.add(const AddImageEvent());
                },
                images: state.newProduct?.images,
              ),
              AddNameForm(
                onChanged: (title) {
                  bloc.add(ChangeItemTitleEvent(title: title));
                },
              ),
              SelectCategoryForm(
                categoryName: state.newProduct?.category?.name,
                onCategoryTap: () async {
                  final category = await triggerBottomSheet<Map<String, List<ModelItem?>?>>(
                    content: BlocProvider(create: (context) => sl<CategoryBloc>(), child: const CategoriesPage()),
                  );
                  if (category != null) {
                    bloc.add(ChangeCategoryEvent(category: SelectedCategory(id: 1, name: category.keys.first)));
                    bloc.add(SetModelsEvent(models: category.values.first?.whereType<ModelItem>().toList() ?? []));
                  }
                },
              ),
              RequirementsForm(
                onTradeChange: (val) {
                  bloc.add(ChangeTradeEvent(value: val));
                },
                trade: state.newProduct?.trade ?? false,
                onMoneyTypeChange: (moneyType) {
                  bloc.add(ChangeMoneyTypeEvent(value: moneyType));
                },
                moneyType: state.newProduct?.moneyType ?? '',
                onMethodChange: (method) {
                  bloc.add(ChangeSellMethod(method: method));
                },
                sellMethod: state.sellMethod,
                onPriceChanged: (value) {
                  bloc.add(ChangePriceEvent(value));
                },
              ),
              ParametsForm(
                brand: state.newProduct?.selectedModel?.name,
                onBrandsTap: () async {
                  final selectedBrand = await triggerBottomSheet(content: BrandsSheet(brands: state.models));
                  if (selectedBrand != null) {
                    bloc.add(ChangeModelsEvent(model: selectedBrand));
                  }
                },
                condition: state.newProduct?.condition ?? Condition.newProduct,
                onConditionChange: (condition) {
                  bloc.add(ChangeConditionEvent(condition: condition));
                },
              ),
              DecriptionsForm(
                onChanged: (value) {
                  bloc.add(ChangeDescriptionEvent(value: value));
                },
              ),
              MeetPlaceForm(
                onAdressChanged: (adress) {
                  bloc.add(ChangeAdressEvent(value: adress));
                },
                shipping: state.newProduct?.dostafca ?? false,
                onShippingChange: (val) {
                  bloc.add(ChangeShippingEvent(value: val));
                },
                region: state.newProduct?.region?.name,
                onRegionTap: () async {
                  final selectedRegion = await triggerBottomSheet(
                    content: BlocProvider(create: (context) => sl<RegionsBloc>(), child: RegionsSheet()),
                  );
                  if (selectedRegion != null) {
                    bloc.add(ChangeRegionEvent(region: selectedRegion));
                  }
                },
              ),
              ContancsForm(
                onNameChanged: (String name) {
                  bloc.add(ChangeNameEvent(name: name));
                },
                onPhoneChanged: (String phone) {
                  final unmaskedValue = phone.replaceAll(RegExp(r'[^0-9]'), '');
                  bloc.add(ChangePhoneEvent(phone: "+998$unmaskedValue"));
                },
              ),
            ];

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ProgressBar(
                      currentPage: state.currentPageNumber,
                      completionProgress: state.completionPercentage,
                      value: state.completionProgress,
                      onBackTap: () {
                        if (state.currentPage > 0) {
                          bloc.add(const PreviousPageEvent());
                        } else {
                          context.pop();
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: state.pageController,
                        itemBuilder: (context, index) => forms[index],
                        itemCount: forms.length,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ButtonWithScale(
                      isLoading: state.apiStatus == ApiStatus.loading,
                      text: 'auth.login.continue'.tr(),
                      onPressed: () => bloc.add(const ValidateAndProceedEvent()),
                      textStyle: TextStyle(color: context.color.white, fontWeight: FontWeight.w500),
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
