import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/wallet.dart';

class Input extends StatelessWidget {
  const Input({
    this.hintText = 'Input',
    this.maxLines = 1,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.obscureText = false,
    this.readOnly = false,
    this.focusNode,
    this.maxLength,
    this.minLines,
    this.prefixText,
    this.textInputAction = TextInputAction.unspecified,
    this.textInputType = TextInputType.text,
    this.controller,
    this.errorText,
    this.initialValue,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.prefixIcon,
  });
  final String hintText;
  final String prefixText;
  final int maxLines;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool obscureText;
  final int maxLength;
  final int minLines;
  final TextEditingController controller;
  final String errorText;
  final String initialValue;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String) onChanged;
  final void Function(String) onFieldSubmitted;
  final void Function() onEditingComplete;
  final void Function(String) onSaved;
  final String Function(String) validator;
  final bool readOnly;
  final Widget prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        readOnly: readOnly,
        validator: validator,
        focusNode: focusNode,
        controller: controller,
        maxLines: maxLines,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        maxLength: maxLength,
        minLines: minLines,
        enableInteractiveSelection: true,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        style: TextStyle(
          fontSize: 18.ssp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          errorText: errorText,
          prefixIcon: prefixIcon,
          counterStyle: const TextStyle(color: Color(0xFF737373)),
          fillColor: AppColors.lightBackround,
          alignLabelWithHint: true,
          hintStyle: TextStyle(
            fontSize: 18.ssp,
            fontWeight: FontWeight.w300,
            color: const Color(0xFF737373),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.w),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.w),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.w),
            borderSide: const BorderSide(
              color: AppColors.danger,
            ),
          ),
          contentPadding: EdgeInsets.all(14.w),
          filled: true,
          prefixText: prefixText,
          hintText: hintText,
        ),
      ),
    );
  }
}
