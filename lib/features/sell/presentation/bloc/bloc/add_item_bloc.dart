import 'dart:io';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/categories/domain/entities/selected_category.dart';
import 'package:elonchi/features/regions/data/regions_response.dart';
import 'package:elonchi/features/sell/data/create_item_request.dart';
import 'package:elonchi/features/sell/domain/entities/condition.dart';
import 'package:elonchi/features/sell/domain/entities/sell_method.dart';
import 'package:elonchi/features/sell/domain/repository/create_item_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  final CreateItemRepo reporisitory;

  AddItemBloc(this.reporisitory)
    : super(
        AddItemState(
          newProduct: CreateProductRequest(),
          pageController: PageController(initialPage: 0),
          currentPage: 0.0,
        ),
      ) {
    on<AddImageEvent>(onAddImageEvent);
    on<ImageDeleteEvent>(onDeleteImage);
    on<NextPageEvent>(onNextPage);
    on<PreviousPageEvent>(onPreviousPage);
    on<ChangeItemTitleEvent>(changeItemTitle);
    on<ChangeCategoryEvent>(onChangeCategory);
    on<ChangePriceEvent>(onChangePrice);
    on<ChangeSellMethod>(onChangeSellMethod);
    on<ChangeMoneyTypeEvent>(onChangeMoneyType);
    on<ChangeDescriptionEvent>(onChangeDescrioption);
    on<ChangeConditionEvent>(onChangeCondition);
    on<SetModelsEvent>(onChangeModels);
    on<ChangeModelsEvent>(onChangeModel);
    on<ChangeRegionEvent>(onChangeRegion);
    on<ChangeShippingEvent>(onShippingChange);
    on<ChangeNameEvent>(onNameChanged);
    on<ChangePhoneEvent>(onPhoneChanged);
    on<CreateItemEvent>(onCreateItemEvent);
    on<ChangeAdressEvent>(onChangeAdress);
    on<ValidateAndProceedEvent>(onValidateAndProceed);
  }

  Future<File?> compressFile(File file) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${file.path}_compressed.jpg',
      quality: 70, // reduce quality
    );

    return result != null ? File(result.path) : null;
  }

  void onValidateAndProceed(ValidateAndProceedEvent event, Emitter<AddItemState> emit) {
    final error = _validateCurrentPage();
    if (error != null) {
      emit(state.copyWith(validationError: error));
      emit(state.copyWith(clearValidationError: true));
      return;
    }

    if (state.currentPage == 7.0) {
      add(const CreateItemEvent());
    } else {
      add(const NextPageEvent());
    }
  }

  String? _validateCurrentPage() {
    return switch (state.currentPage) {
      0.0 => (state.newProduct?.images?.isEmpty ?? true) ? 'Please add at least one image' : null,
      1.0 => (state.newProduct?.title?.trim().isEmpty ?? true) ? 'Please enter a title' : null,
      2.0 => state.newProduct?.category == null ? 'Please select a category' : null,
      3.0 => (state.newProduct?.price == null) ? 'Please enter a price' : null,
      4.0 => state.newProduct?.selectedModel == null ? 'Please select a brand' : null,
      5.0 => (state.newProduct?.description?.trim().isEmpty ?? true) ? 'Please enter a description' : null,
      6.0 => state.newProduct?.region == null ? 'Please select a region' : null,
      7.0 => (state.newProduct?.phoneNumber?.isEmpty ?? true) ? 'Please enter a phone number' : null,
      _ => null,
    };
  }

  void onAddImageEvent(AddImageEvent event, Emitter<AddItemState> emit) async {
    final picker = ImagePicker();
    final List<XFile> picked = await picker.pickMultiImage(
      imageQuality: 85, // optional first-level compression
    );

    final List<File> files = [];

    for (final x in picked) {
      final originalFile = File(x.path);

      // 🔹 original size
      final originalBytes = await originalFile.length();
      final originalMB = originalBytes / (1024 * 1024);

      print('Original size: ${originalMB.toStringAsFixed(2)} MB');

      // 🔹 compress
      final compressed = await compressFile(originalFile);

      if (compressed != null) {
        final compressedBytes = await compressed.length();
        final compressedMB = compressedBytes / (1024 * 1024);

        print('Compressed size: ${compressedMB.toStringAsFixed(2)} MB');

        files.add(compressed);
      } else {
        files.add(originalFile); // fallback
      }
    }

    emit(state.copyWith(newProduct: state.newProduct?.copyWith(images: files)));
  }

  void changeItemTitle(ChangeItemTitleEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(title: event.title)));
  }

  void onDeleteImage(ImageDeleteEvent event, Emitter<AddItemState> emit) {
    final images = List<File>.from(state.newProduct?.images ?? []);
    images.removeAt(event.index);
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(images: images)));
  }

  void onNextPage(NextPageEvent event, Emitter<AddItemState> emit) {
    final newPage = state.currentPage + 1;
    if (newPage < 8) {
      state.pageController?.animateToPage(
        newPage.toInt(),
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
      emit(state.copyWith(currentPage: newPage));
    }
  }

  void onPreviousPage(PreviousPageEvent event, Emitter<AddItemState> emit) {
    final newPage = state.currentPage - 1;
    if (newPage >= 0) {
      state.pageController?.animateToPage(
        newPage.toInt(),
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
      emit(state.copyWith(currentPage: newPage));
    }
  }

  void onCreateItemEvent(CreateItemEvent event, Emitter<AddItemState> emit) async {
    emit(state.copyWith(apistatus: ApiStatus.loading));
    final result = await reporisitory.createProduct(state.newProduct!);
    if (result.ok) {
      emit(state.copyWith(apistatus: ApiStatus.success));
    } else {
      emit(state.copyWith(apistatus: ApiStatus.error));
    }
  }

  void onChangeCategory(ChangeCategoryEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(category: event.category)));
  }

  void onChangeSellMethod(ChangeSellMethod event, Emitter<AddItemState> emit) {
    emit(state.copyWith(sellmethod: event.method));
  }

  void onChangePrice(ChangePriceEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(price: event.price)));
  }

  void onChangeMoneyType(ChangeMoneyTypeEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(moneyType: event.value)));
  }

  void onChangeDescrioption(ChangeDescriptionEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(description: event.value)));
  }

  void onChangeCondition(ChangeConditionEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(condition: event.condition));
  }

  void onChangeModels(SetModelsEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(models: event.models));
  }

  void onChangeModel(ChangeModelsEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(selectedModel: event.model)));
  }

  void onChangeRegion(ChangeRegionEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(region: event.region)));
  }

  void onShippingChange(ChangeShippingEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(dostafca: event.value)));
  }

  void onNameChanged(ChangeNameEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(contactname: event.name)));
  }

  void onPhoneChanged(ChangePhoneEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(phoneNumber: event.phone)));
  }

  void onChangeAdress(ChangeAdressEvent event, Emitter<AddItemState> emit) {
    emit(state.copyWith(newProduct: state.newProduct?.copyWith(address: event.value)));
  }
}
