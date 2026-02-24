import 'dart:io';

import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatInputField extends StatefulWidget {
  final File? imageFile;
  final VoidCallback onImageAddTap;
  final VoidCallback? onImageRemoveTap;
  final String hint;
  final bool enabled;
  final VoidCallback onSend;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  const ChatInputField({
    super.key,
    this.controller,
    this.focusNode,
    this.imageFile,
    required this.onImageAddTap,
    this.onImageRemoveTap,
    required this.onSend,
    required this.enabled,
    required this.hint,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final ScrollController _scrollController = ScrollController();

  bool _isScrollable = false;
  double _scrollThumbHeight = 0;
  double _scrollThumbPosition = 0;
  double _totalContentHeight = 0;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_calculateScrollMetrics);
    _scrollController.addListener(_updateScrollPosition);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_calculateScrollMetrics);
    _scrollController.removeListener(_updateScrollPosition);
    widget.controller?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateScrollMetrics() {
    final text = widget.controller?.text;

    // Calculate text height using TextPainter
    final textPainter = TextPainter(
      text: TextSpan(
        text: (text ?? "").isEmpty ? 'A' : text, // Use 'A' for empty to get base height
        style: const TextStyle(fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    final maxWidth = MediaQuery.of(context).size.width - 120;
    textPainter.layout(maxWidth: maxWidth);

    _totalContentHeight = textPainter.height + 24; // Add padding

    final visibleHeight = _totalContentHeight > 140 ? 140.0 : _totalContentHeight;

    setState(() {
      _isScrollable = _totalContentHeight > 140;

      if (_isScrollable) {
        // Calculate thumb height (ratio of visible to total)
        _scrollThumbHeight = (visibleHeight / _totalContentHeight) * visibleHeight;
        // Set minimum height for thumb
        _scrollThumbHeight = _scrollThumbHeight.clamp(20.0, visibleHeight);
      }
    });

    // Update scroll position after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollPosition();
    });
  }

  void _updateScrollPosition() {
    if (!_scrollController.hasClients || !_isScrollable) return;

    final scrollOffset = _scrollController.offset;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    if (maxScrollExtent <= 0) return;

    final visibleHeight = 140.0;
    final scrollableHeight = visibleHeight - _scrollThumbHeight;

    setState(() {
      _scrollThumbPosition = (scrollOffset / maxScrollExtent) * scrollableHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: context.color.background),
      child: Container(
        padding: const EdgeInsets.only(right: 4, left: 12, bottom: 6),
        decoration: BoxDecoration(color: context.color.bgelevation, borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image preview
            if (widget.imageFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(widget.imageFile!, width: 60, height: 60, fit: BoxFit.cover),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: GestureDetector(
                            onTap: widget.onImageRemoveTap,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Text input row
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 140),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WScaleAnimation(
                    onTap: widget.onImageAddTap,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      width: 40,
                      child: SvgPicture.asset(PIcons.imageAddIcon),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        enabled: widget.enabled,
                        focusNode: widget.focusNode,
                        controller: widget.controller,
                        maxLines: null,
                        minLines: 1,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: widget.hint,
                          hintStyle: TextStyle(fontSize: 14, color: context.color.textSoft),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                        ),
                      ),
                    ),
                  ),
                  SendButton(onTap: widget.onSend, canSend: widget.controller?.text.trim().isNotEmpty == true),
                  if (_isScrollable)
                    Container(
                      width: 3,
                      height: 120,
                      margin: const EdgeInsets.only(left: 6, right: 1, bottom: 7, top: 2),
                      child: Stack(
                        children: [
                          Positioned(
                            top: _scrollThumbPosition,
                            child: Container(
                              width: 3,
                              height: _scrollThumbHeight,
                              decoration: BoxDecoration(
                                color: Color(0xffA8A8A8),
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
