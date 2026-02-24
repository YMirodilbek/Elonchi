import 'dart:ui';

import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/features/single_item/presentation/widgets/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FloatingMessageInput extends StatefulWidget {
  final void Function(String value) onSendMessage;
  final Function(String)? onQuickActionTap;

  const FloatingMessageInput({super.key, required this.onSendMessage, this.onQuickActionTap});

  @override
  State<FloatingMessageInput> createState() => _FloatingMessageInputState();
}

class _FloatingMessageInputState extends State<FloatingMessageInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.50),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, -5))],
          ),
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: MediaQuery.of(context).padding.bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QuickActions(
                onTap: (value) {
                  setState(() {
                    _controller.text = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(24)),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Здравствуйте! Хочу купить',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              widget.onSendMessage(_controller.text);
                            },
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(12),
                              child: SvgPicture.asset(PIcons.sendIcon, color: Color(0xFF00A693)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
