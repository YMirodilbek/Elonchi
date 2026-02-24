class ChatListResponse {
  final int? count;
  final String? next;
  final String? previous;
  final List<ChatRoomResponse>? results;

  const ChatListResponse({this.count, this.next, this.previous, this.results});

  factory ChatListResponse.fromJson(Map<String, dynamic> json) {
    return ChatListResponse(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List?)?.map((e) => ChatRoomResponse.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'next': next, 'previous': previous, 'results': results?.map((e) => e.toJson()).toList()};
  }

  ChatListResponse copyWith({int? count, String? next, String? previous, List<ChatRoomResponse>? results}) {
    return ChatListResponse(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}

class ChatRoomResponse {
  final int? id;
  final ProductMessage? product;
  final ChatUserResponse? user;
  final int? user1;
  final int? user2;
  final int? owner;
  final String? type;
  final LastMessageResponse? lastMessage;
  final String? roomName;
  final String? createdAt;
  final int? unreadCount;

  const ChatRoomResponse({
    this.id,
    this.product,
    this.user,
    this.user1,
    this.user2,
    this.owner,
    this.type,
    this.lastMessage,
    this.roomName,
    this.createdAt,
    this.unreadCount,
  });

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json) {
    return ChatRoomResponse(
      id: json['id'] as int?,
      product: json['product'] != null
          ? (json['product'] is Map<String, dynamic> ? ProductMessage.fromJson(json['product']) : null)
          : null,
      user: json['user'] != null ? ChatUserResponse.fromJson(json['user']) : null,
      user1: json['user_1'] as int?,
      user2: json['user_2'] as int?,
      owner: json['owner'] as int?,
      type: json['type'] as String?,
      lastMessage: json['last_message'] != null ? LastMessageResponse.fromJson(json['last_message']) : null,
      roomName: json['room_name'] as String?,
      createdAt: json['created_at'] as String?,
      unreadCount: json['unread_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'user': user?.toJson(),
      'user_1': user1,
      'user_2': user2,
      'owner': owner,
      'type': type,
      'last_message': lastMessage?.toJson(),
      'room_name': roomName,
      'created_at': createdAt,
      'unread_count': unreadCount,
    };
  }

  ChatRoomResponse copyWith({
    int? id,
    ProductMessage? product,
    ChatUserResponse? user,
    int? user1,
    int? user2,
    int? owner,
    String? type,
    LastMessageResponse? lastMessage,
    String? roomName,
    String? createdAt,
    int? unreadCount,
  }) {
    return ChatRoomResponse(
      id: id ?? this.id,
      product: product ?? this.product,
      user: user ?? this.user,
      user1: user1 ?? this.user1,
      user2: user2 ?? this.user2,
      owner: owner ?? this.owner,
      type: type ?? this.type,
      lastMessage: lastMessage ?? this.lastMessage,
      roomName: roomName ?? this.roomName,
      createdAt: createdAt ?? this.createdAt,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

class ChatUserResponse {
  final int? id;
  final String? phone;
  final String? image;
  final String? firstName;
  final String? lastName;
  final bool? isStaff;
  final bool? isActive;

  const ChatUserResponse({this.id, this.phone, this.image, this.firstName, this.lastName, this.isStaff, this.isActive});

  factory ChatUserResponse.fromJson(Map<String, dynamic> json) {
    return ChatUserResponse(
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

  ChatUserResponse copyWith({
    int? id,
    String? phone,
    String? image,
    String? firstName,
    String? lastName,
    bool? isStaff,
    bool? isActive,
  }) {
    return ChatUserResponse(
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

class LastMessageResponse {
  final String? content;
  final String? timestamp;
  final int? senderId;

  const LastMessageResponse({this.content, this.timestamp, this.senderId});

  factory LastMessageResponse.fromJson(Map<String, dynamic> json) {
    return LastMessageResponse(
      content: json['content'] as String?,
      timestamp: json['timestamp'] as String?,
      senderId: json['sender_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'content': content, 'timestamp': timestamp, 'sender_id': senderId};
  }

  LastMessageResponse copyWith({String? content, String? timestamp, int? senderId}) {
    return LastMessageResponse(
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      senderId: senderId ?? this.senderId,
    );
  }
}

class ProductMessage {
  final int? id;
  final String? title;
  final String? price;
  final String? moneyType;
  final String? image;

  const ProductMessage({this.id, this.title, this.price, this.moneyType, this.image});

  factory ProductMessage.fromJson(Map<String, dynamic> json) {
    return ProductMessage(
      id: json['id'] as int?,
      title: json['title'] as String?,
      price: json['price']?.toString(),
      moneyType: json['money_type'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'price': price, 'money_type': moneyType, 'image': image};
  }

  ProductMessage copyWith({int? id, String? title, String? price, String? moneyType, String? image}) {
    return ProductMessage(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      moneyType: moneyType ?? this.moneyType,
      image: image ?? this.image,
    );
  }
}
