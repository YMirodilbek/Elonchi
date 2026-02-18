part of 'edit_item_bloc.dart';

sealed class EditItemEvent extends Equatable {
  const EditItemEvent();

  @override
  List<Object> get props => [];
}

final class EditItemRequestEvent extends EditItemEvent {
  const EditItemRequestEvent();

  @override
  List<Object> get props => [];
}

final class InitDataEvent extends EditItemEvent {
  final EditItemRequest request;
  const InitDataEvent(this.request);
  @override
  List<Object> get props => [request];
}

final class ChangePriceEvent extends EditItemEvent {
  final String price;
  const ChangePriceEvent(this.price);
  @override
  List<Object> get props => [price];
}

final class ChangeSellMethod extends EditItemEvent {
  final SellMethod method;
  const ChangeSellMethod({required this.method});
  @override
  List<Object> get props => [method];
}

final class ChangeMoneyTypeEvent extends EditItemEvent {
  final String value;
  const ChangeMoneyTypeEvent({required this.value});
  @override
  List<Object> get props => [value];
}

final class ChangeTradeEvent extends EditItemEvent {
  final bool value;
  const ChangeTradeEvent(this.value);
  @override
  List<Object> get props => [value];
}
