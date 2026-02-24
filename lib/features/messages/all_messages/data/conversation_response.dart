class ConversationResponse {
  final int? count;
  final String? next;
  final String? previous;
  final List<MessageResponse>? results;

  const ConversationResponse({this.count, this.next, this.previous, this.results});

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    return ConversationResponse(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List?)?.map((e) => MessageResponse.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'next': next, 'previous': previous, 'results': results?.map((e) => e.toJson()).toList()};
  }

  ConversationResponse copyWith({int? count, String? next, String? previous, List<MessageResponse>? results}) {
    return ConversationResponse(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}

class MessageResponse {
  final int? id;
  final bool? i;
  final SenderResponse? sender;
  final int? room;
  final String? image;
  final String? content;
  final String? timestamp;

  const MessageResponse({this.id, this.i, this.sender, this.room, this.image, this.content, this.timestamp});

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      id: json['id'] as int?,
      i: json['i'] as bool?,
      sender: json['sender'] != null ? SenderResponse.fromJson(json['sender']) : null,
      room: json['room'] as int?,
      image: json['image'] as String?,
      content: json['content'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'i': i,
      'sender': sender?.toJson(),
      'room': room,
      'image': image,
      'content': content,
      'timestamp': timestamp,
    };
  }

  MessageResponse copyWith({
    int? id,
    bool? i,
    SenderResponse? sender,
    int? room,
    String? image,
    String? content,
    String? timestamp,
  }) {
    return MessageResponse(
      id: id ?? this.id,
      i: i ?? this.i,
      sender: sender ?? this.sender,
      room: room ?? this.room,
      image: image ?? this.image,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class SenderResponse {
  final int? id;
  final String? phone;
  final String? image;
  final String? firstName;
  final String? lastName;
  final bool? isStaff;
  final bool? isActive;

  const SenderResponse({this.id, this.phone, this.image, this.firstName, this.lastName, this.isStaff, this.isActive});

  factory SenderResponse.fromJson(Map<String, dynamic> json) {
    return SenderResponse(
      id: json['id'] as int?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      isStaff: json['is_staff'] as bool?,
      isActive: json['is_active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'image': image,
      'first_name': firstName,
      'last_name': lastName,
      'is_staff': isStaff,
      'is_active': isActive,
    };
  }

  SenderResponse copyWith({
    int? id,
    String? phone,
    String? image,
    String? firstName,
    String? lastName,
    bool? isStaff,
    bool? isActive,
  }) {
    return SenderResponse(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isStaff: isStaff ?? this.isStaff,
      isActive: isActive ?? this.isActive,
    );
  }
}
