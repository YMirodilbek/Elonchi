class EditItemRequest {
  final int id;
  final String? title;
  final String? description;
  final int? price;
  final String? moneyType;
  final bool? trade;

  EditItemRequest({required this.id, this.title, this.description, this.price, this.moneyType, this.trade});

  Map<String, dynamic> toJson() => {
    if (title != null) 'title': title,
    if (description != null) 'description': description,
    if (price != null) 'price': price,
    if (moneyType != null) 'money_type': moneyType,
    if (trade != null) 'trade': trade,
  };

  EditItemRequest copyWith({int? id, String? title, String? description, int? price, String? moneyType, bool? trade}) {
    return EditItemRequest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      moneyType: moneyType ?? this.moneyType,
      trade: trade ?? this.trade,
    );
  }
}
