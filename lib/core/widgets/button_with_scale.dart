import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';

class ButtonWithScale extends StatefulWidget {
  final double radius;
  final double horizontalPadding, verticalPadding;
  final double horizontalMargin, verticalMargin;
  final Function()? onPressed;
  final Widget? child;
  final String? text;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool isLoading;
  final Color? loadingColor;

  const ButtonWithScale({
    super.key,
    this.radius = 16,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
    this.onPressed,
    this.child,
    this.text,
    this.color,
    this.borderColor,
    this.textStyle,
    this.isLoading = false,
    this.loadingColor,
  });

  @override
  State<ButtonWithScale> createState() => _ButtonWithScaleState();
}

class _ButtonWithScaleState extends State<ButtonWithScale> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WScaleAnimation(
          onTap: widget.onPressed,
          isDisabled: widget.onPressed == null || widget.isLoading,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: (widget.isLoading)
                ? EdgeInsets.all(16)
                : EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: widget.verticalPadding),
            margin: EdgeInsets.symmetric(horizontal: widget.horizontalMargin, vertical: widget.verticalMargin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: widget.onPressed != null
                  ? (widget.color ?? context.colorScheme.primary)
                  : context.colorScheme.primary.withValues(alpha: 0.1),
              border: Border.all(
                color: widget.borderColor ?? Colors.transparent,
                width: widget.borderColor != null ? 1 : 0,
              ),
            ),
            alignment: Alignment.center,
            child: widget.isLoading
                ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: widget.loadingColor ?? context.color.white,
                      strokeCap: StrokeCap.round,
                    ),
                  )
                : widget.child ??
                      Text(widget.text ?? '', style: widget.textStyle ?? context.textStyle.elevatedButtonText),
          ),
        ),
      ],
    );
  }
}
