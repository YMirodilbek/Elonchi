import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/features/sell/presentation/bloc/bloc/add_item_bloc.dart';
import 'package:elonchi/features/sell/presentation/page_view/add_characteristics.dart';
import 'package:elonchi/features/sell/presentation/page_view/add_decription.dart';
import 'package:elonchi/features/sell/presentation/page_view/add_name.dart';
import 'package:elonchi/features/sell/presentation/page_view/contacts.dart';
import 'package:elonchi/features/sell/presentation/page_view/image_add.dart';
import 'package:elonchi/features/sell/presentation/page_view/meet_place.dart';
import 'package:elonchi/features/sell/presentation/page_view/requirements.dart';
import 'package:elonchi/features/sell/presentation/page_view/selecte_category.dart';
import 'package:elonchi/features/sell/presentation/widgets/progress_bar.dart';
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
    final List<Widget> forms = [
      BlocBuilder<AddItemBloc, AddItemState>(
        builder: (context, state) {
          return ImageAddForm(
            onDeleteImage: (int index) {
              bloc.add(ImageDeleteEvent(index: index));
            },
            onImagetap: () {
              bloc.add(const AddImageEvent());
            },
            images: state.newProduct?.images,
          );
        },
      ),
      AddNameForm(
        onChanged: (title) {
          bloc.add(ChangeItemTitleEvent(title: title));
        },
      ),
      SelectCategoryForm(),
      RequirementsForm(),
      ParametsForm(),
      DecriptionsForm(),
      MeetPlaceForm(),
      ContancsForm(),
    ];

    return Scaffold(
      body: BlocBuilder<AddItemBloc, AddItemState>(
        builder: (context, state) {
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
                    text: 'auth.login.continue'.tr(),
                    onPressed: () {
                      bloc.add(const NextPageEvent());
                    },
                    textStyle: TextStyle(color: context.color.white, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
