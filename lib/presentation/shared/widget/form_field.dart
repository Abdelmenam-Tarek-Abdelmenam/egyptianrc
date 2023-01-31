import 'package:flutter/material.dart';

import '../../resources/styles_manager.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField(
      {required this.controller,
      this.fillHint,
      required this.title,
      this.prefix,
      this.maxLines,
      this.isPass = false,
      this.hideBorder = false,
      this.validator,
      this.keyboardType,
      this.suffix,
      this.onChanged,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final String? fillHint;
  final String title;
  final IconData? prefix;
  final bool isPass;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final int? maxLines;
  final bool hideBorder;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingManager.p8.copyWith(top: 2),
      decoration: BoxDecoration(
          borderRadius: StyleManager.border,
          border: Border.all(
              width: 3,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8)),
          color: Colors.transparent),
      child: TextFormField(
        controller: controller,
        obscureText: isPass,
        onChanged: onChanged,
        maxLines: maxLines ?? 1,
        autofillHints: fillHint == null ? null : [fillHint!],
        keyboardType: keyboardType,
        validator: validator,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            fontSize: 16),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(right: 5.0),
          errorStyle: const TextStyle(fontSize: 10),
          errorBorder: InputBorder.none,
          border: hideBorder
              ? InputBorder.none
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      width: 3)),
          enabledBorder: hideBorder
              ? InputBorder.none
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      width: 3)),
          suffixIcon: suffix,
          prefixIcon: prefix == null
              ? null
              : Icon(prefix,
                  size: 20, color: Theme.of(context).colorScheme.primary),
          labelText: title,
          labelStyle: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
