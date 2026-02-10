import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinInput extends StatefulWidget {
  final bool error;
  final Function(String) onCompleted;

  const PinInput({super.key, required this.onCompleted, required this.error});

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: context.color.bgElevattion2, borderRadius: BorderRadius.circular(25)),
      textStyle: TextStyle(),
    );

    final submittedPinTheme = PinTheme(
      textStyle: TextStyle(
        fontSize: 24,
        color: widget.error ? context.color.errorColor : context.color.textStrong,
        fontWeight: FontWeight.w700,
      ),

      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(25)),
    );

    return Pinput(
      controller: controller,
      focusNode: focusNode,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme,
      submittedPinTheme: submittedPinTheme,
      showCursor: false,
      onCompleted: widget.onCompleted,
      preFilledWidget: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: context.color.bgElevattion2, borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}
