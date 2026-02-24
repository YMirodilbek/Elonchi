import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Custom phone formatter that handles cursor positioning better
class UzbekPhoneFormatter extends TextInputFormatter {
  static const String _mask = '## ### ##-##';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Remove all non-digits
    final digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limit to 9 digits max
    final limitedDigits = digitsOnly.length > 9 ? digitsOnly.substring(0, 9) : digitsOnly;

    // Apply mask format
    String formatted = '';
    int digitIndex = 0;

    for (int i = 0; i < _mask.length && digitIndex < limitedDigits.length; i++) {
      if (_mask[i] == '#') {
        formatted += limitedDigits[digitIndex];
        digitIndex++;
      } else {
        formatted += _mask[i];
      }
    }

    // Calculate cursor position
    int cursorPosition = formatted.length;
    if (newValue.selection.baseOffset < text.length) {
      // Try to maintain relative cursor position
      final relativeCursor = newValue.selection.baseOffset;
      int newCursor = 0;
      int oldDigitCount = 0;

      for (int i = 0; i < relativeCursor && i < text.length; i++) {
        if (RegExp(r'[0-9]').hasMatch(text[i])) {
          oldDigitCount++;
        }
      }

      int digitsSeen = 0;
      for (int i = 0; i < formatted.length; i++) {
        if (RegExp(r'[0-9]').hasMatch(formatted[i])) {
          digitsSeen++;
          if (digitsSeen >= oldDigitCount) {
            newCursor = i + 1;
            break;
          }
        }
      }

      cursorPosition = newCursor.clamp(0, formatted.length);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

class PhoneInputs extends StatefulWidget {
  final bool enabled;
  final double horMargin;
  final VoidCallback onTap;

  final void Function(String value) onChanged;

  const PhoneInputs({super.key, this.horMargin = 0, this.enabled = true, required this.onTap, required this.onChanged});

  @override
  State<PhoneInputs> createState() => _PhoneInputsState();
}

class _PhoneInputsState extends State<PhoneInputs> {
  late final UzbekPhoneFormatter _phoneFormatter;

  @override
  void initState() {
    super.initState();
    _phoneFormatter = UzbekPhoneFormatter();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text('+998', style: TextStyle(fontSize: 16, color: context.color.textStrong)),
        ),
        Expanded(
          child: TextField(
            enabled: widget.enabled,
            onChanged: (value) {
              final unmaskedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
              widget.onChanged(unmaskedValue);
            },
            keyboardType: TextInputType.number,
            inputFormatters: [_phoneFormatter],
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'auth.login.phone_hint'.tr(),
              hintStyle: TextStyle(color: context.color.textSoft, fontSize: 16),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.color.bgelevation, width: 1)),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.color.bgelevation, width: 1)),
            ),
          ),
        ),
      ],
    );
  }
}
