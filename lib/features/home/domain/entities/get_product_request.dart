class GetProductRequest {
  final String? query;
  final int? pageNum;
  final String? id;
  final int? region;
  final String? regionName;
  final int? categoryId;
  final int? model;
  final int? price;
  final String? trade;
  final String? categoryName;
  final String? exchange;
  final String? sold;
  final String? title;
  final String? contactName;
  final String? condition;

  const GetProductRequest({
    this.regionName,
    this.categoryName,
    this.query,
    this.region,
    this.pageNum,
    this.id,
    this.categoryId,
    this.model,
    this.price,
    this.trade,
    this.exchange,
    this.sold,
    this.title,
    this.contactName,
    this.condition,
  });

  GetProductRequest copyWith({
    String? categoryName,
    String? regionName,
    String? query,
    int? region,
    int? pageNum,
    String? id,
    int? categoryId,
    int? model,
    int? price,
    String? trade,
    String? exchange,
    String? sold,
    String? title,
    String? contactName,
    String? condition,
  }) {
    return GetProductRequest(
      categoryName: categoryName ?? this.categoryName,
      regionName: regionName ?? this.regionName,
      query: query ?? this.query,
      region: region ?? this.region,
      pageNum: pageNum ?? this.pageNum,
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      model: model ?? this.model,
      price: price ?? this.price,
      trade: trade ?? this.trade,
      exchange: exchange ?? this.exchange,
      sold: sold ?? this.sold,
      title: title ?? this.title,
      contactName: contactName ?? this.contactName,
      condition: condition ?? this.condition,
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      "q": query,
      'page': pageNum,
      'region': region,
      'id': id,
      'category_id': categoryId,
      'model': model,
      'price': price,
      'trade': trade,
      'exchange': exchange,
      'sold': sold,
      'title': title,
      'contact_name': contactName,
      'condition': condition,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
