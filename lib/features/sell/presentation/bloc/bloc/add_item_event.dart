part of 'add_item_bloc.dart';

sealed class AddItemEvent extends Equatable {
  const AddItemEvent();
}

final class AddImageEvent extends AddItemEvent {
  const AddImageEvent();

  @override
  List<Object> get props => [];
}

final class ImageDeleteEvent extends AddItemEvent {
  final int index;
  const ImageDeleteEvent({required this.index});
  @override
  List<Object> get props => [index];
}

final class GetUserLocationEvent extends AddItemEvent {
  const GetUserLocationEvent();
  @override
  List<Object> get props => [];
}

final class NextPageEvent extends AddItemEvent {
  const NextPageEvent();
  @override
  List<Object> get props => [];
}

final class PreviousPageEvent extends AddItemEvent {
  const PreviousPageEvent();
  @override
  List<Object> get props => [];
}

final class ChangeItemTitleEvent extends AddItemEvent {
  final String title;
  const ChangeItemTitleEvent({required this.title});

  @override
  List<Object> get props => [title];
}

final class ChangeCategoryEvent extends AddItemEvent {
  final SelectedCategory category;
  const ChangeCategoryEvent({required this.category});
  @override
  List<Object> get props => [category];
}

final class ChangePriceEvent extends AddItemEvent {
  final String price;
  const ChangePriceEvent(this.price);
  @override
  List<Object> get props => [price];
}

final class ChangeSellMethod extends AddItemEvent {
  final SellMethod method;
  const ChangeSellMethod({required this.method});
  @override
  List<Object> get props => [method];
}

final class ChangeMoneyTypeEvent extends AddItemEvent {
  final String value;
  const ChangeMoneyTypeEvent({required this.value});
  @override
  List<Object> get props => [value];
}

final class ChangeDescriptionEvent extends AddItemEvent {
  final String value;
  const ChangeDescriptionEvent({required this.value});

  @override
  List<Object> get props => [value];
}

final class SetModelsEvent extends AddItemEvent {
  final List<ModelItem> models;
  const SetModelsEvent({required this.models});

  @override
  List<Object> get props => [models];
}

final class ChangeConditionEvent extends AddItemEvent {
  final Condition condition;
  const ChangeConditionEvent({required this.condition});

  @override
  List<Object> get props => [condition];
}

final class ChangeModelsEvent extends AddItemEvent {
  final ModelItem model;
  const ChangeModelsEvent({required this.model});

  @override
  List<Object> get props => [model];
}

final class ChangeRegionEvent extends AddItemEvent {
  final RegionResponse region;
  const ChangeRegionEvent({required this.region});

  @override
  List<Object> get props => [region];
}

final class ChangeShippingEvent extends AddItemEvent {
  final bool value;
  const ChangeShippingEvent({required this.value});

  @override
  List<Object> get props => [value];
}

final class ChangeNameEvent extends AddItemEvent {
  final String name;
  const ChangeNameEvent({required this.name});

  @override
  List<Object> get props => [name];
}

final class ChangePhoneEvent extends AddItemEvent {
  final String phone;
  const ChangePhoneEvent({required this.phone});

  @override
  List<Object> get props => [phone];
}

final class CreateItemEvent extends AddItemEvent {
  const CreateItemEvent();
  @override
  List<Object> get props => [];
}

final class ChangeAdressEvent extends AddItemEvent {
  final String value;
  const ChangeAdressEvent({required this.value});
  @override
  List<Object> get props => [value];
}

final class ValidateAndProceedEvent extends AddItemEvent {
  const ValidateAndProceedEvent();

  @override
  List<Object> get props => [];
}
