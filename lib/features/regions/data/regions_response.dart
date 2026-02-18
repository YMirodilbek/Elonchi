class RegionResponse {
  final int? id;
  final String? name;

  const RegionResponse({this.id, this.name});

  factory RegionResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const RegionResponse();

    return RegionResponse(id: json['id'] as int?, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
