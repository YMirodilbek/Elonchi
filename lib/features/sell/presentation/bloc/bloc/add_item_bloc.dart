import 'dart:io';

import 'package:elonchi/features/sell/data/create_item_request.dart';
import 'package:elonchi/features/sell/domain/repository/create_item_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  void onAddImageEvent(AddImageEvent event, Emitter<AddItemState> emit) async {
    final picker = ImagePicker();
    final List<XFile> picked = await picker.pickMultiImage();
    final List<File> files = picked.map((x) => File(x.path)).toList();
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
}
