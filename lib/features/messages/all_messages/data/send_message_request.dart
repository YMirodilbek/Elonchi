import 'dart:io';

class SendMessageRequest {
  final String content;
  final List<File> images;

  const SendMessageRequest({required this.content, this.images = const []});

  SendMessageRequest copyWith({String? content, List<File>? images}) {
    return SendMessageRequest(content: content ?? this.content, images: images ?? this.images);
  }
}
