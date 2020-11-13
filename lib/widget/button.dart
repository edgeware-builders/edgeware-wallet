import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

enum ButtonVariant { filled, outline }

class Button extends StatelessWidget {
  const Button({
    this.onPressed,
    this.text = 'Button',
    this.enabled = true,
    this.textColor = Colors.white,
    this.variant = ButtonVariant.filled,
  });
  final String text;
  final FutureOr<void> Function() onPressed;
  final Color textColor;
  final bool enabled;
  final ButtonVariant variant;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: enabled ? onPressed : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.w,
          ),
          side: variant == ButtonVariant.filled
              ? BorderSide.none
              : const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
        ),
        disabledColor: AppColors.disabled,
        color: variant == ButtonVariant.filled
            ? AppColors.primary
            : Colors.transparent,
        child: Container(
          height: 58.h,
          child: Center(
              child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              text,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.visible,
              maxLines: 1,
              softWrap: false,
              textWidthBasis: TextWidthBasis.parent,
              style: TextStyle(
                color: textColor,
                fontSize: 22.ssp,
                fontWeight: FontWeight.w300,
              ),
            ),
          )),
        ),
      ),
    );
  }
}
