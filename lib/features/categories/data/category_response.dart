class CategoryResponse {
  final int? id;
  final String? img;
  final String? categoryName;
  final String? name;
  final int? level;
  final int? category;
  final List<ModelItem>? models;

  const CategoryResponse({this.id, this.img, this.categoryName, this.name, this.level, this.category, this.models});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'] as int?,
      img: json['img'] as String?,
      categoryName: json['category_name'] as String?,
      name: json['name'] as String?,
      level: json['level'] as int?,
      category: json['category'] as int?,
      models: (json['models'] as List?)?.map((e) => ModelItem.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'category_name': categoryName,
      'name': name,
      'level': level,
      'category': category,
      'models': models?.map((e) => e.toJson()).toList(),
    };
  }
}

class ModelItem {
  final int? id;
  final String? name;
  final int? category;

  const ModelItem({this.id, this.name, this.category});

  factory ModelItem.fromJson(Map<String, dynamic> json) {
    return ModelItem(id: json['id'] as int?, name: json['name'] as String?, category: json['category'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'category': category};
  }
}
