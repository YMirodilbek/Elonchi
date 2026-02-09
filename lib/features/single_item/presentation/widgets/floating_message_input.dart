import 'dart:ui';

import 'package:elonchi/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FloatingMessageInput extends StatelessWidget {
  final bool showTextField;
  final VoidCallback? onSendMessage;
  final Function(String)? onQuickActionTap;

  const FloatingMessageInput({super.key, this.showTextField = false, this.onSendMessage, this.onQuickActionTap});

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
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).padding.bottom + 16),
          child: showTextField ? _buildTextFieldInput() : _buildQuickActionChips(),
        ),
      ),
    );
  }

  Widget _buildTextFieldInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(24)),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Здравствуйте! Хочу купить',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: GestureDetector(
                  onTap: onSendMessage,
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
    );
  }

  Widget _buildQuickActionChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _QuickActionChip(label: 'Торг уместен', onTap: () => onQuickActionTap?.call('Торг уместен')),
          const SizedBox(width: 8),
          _QuickActionChip(label: 'Хочу купить', onTap: () => onQuickActionTap?.call('Хочу купить')),
          const SizedBox(width: 8),
          _QuickActionChip(label: 'Доставка есть?', onTap: () => onQuickActionTap?.call('Доставка есть?')),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _QuickActionChip({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
