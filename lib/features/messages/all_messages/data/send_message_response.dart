class SendMessageResponse {
  final int? id;
  final bool? i;
  final MessageSender? sender;
  final int? room;
  final String? image;
  final String? content;
  final String? timestamp;

  const SendMessageResponse({this.id, this.i, this.sender, this.room, this.image, this.content, this.timestamp});

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) {
    return SendMessageResponse(
      id: json['id'] as int?,
      i: json['i'] as bool?,
      sender: json['sender'] != null ? MessageSender.fromJson(json['sender'] as Map<String, dynamic>) : null,
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

  SendMessageResponse copyWith({
    int? id,
    bool? i,
    MessageSender? sender,
    int? room,
    String? image,
    String? content,
    String? timestamp,
  }) {
    return SendMessageResponse(
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

class MessageSender {
  final int? id;
  final String? phone;
  final String? image;
  final String? firstName;
  final String? lastName;
  final bool? isStaff;
  final bool? isActive;

  const MessageSender({this.id, this.phone, this.image, this.firstName, this.lastName, this.isStaff, this.isActive});

  factory MessageSender.fromJson(Map<String, dynamic> json) {
    return MessageSender(
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

  MessageSender copyWith({
    int? id,
    String? phone,
    String? image,
    String? firstName,
    String? lastName,
    bool? isStaff,
    bool? isActive,
  }) {
    return MessageSender(
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
