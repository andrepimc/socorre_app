import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socorre_app/theme/my_app_colors.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';

class TextInputComponent extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final dynamic maxLines;
  final TextCapitalization? capitalization;
  final dynamic maxLength;
  final Icon? icon;
  final VoidCallback? completed;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? formatters;
  final TextInputType? type;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool password;
  final bool autoFocus;
  final Color? color;
  final bool readOnly;
  final bool mandatory;
  const TextInputComponent(
      {super.key,
      required this.controller,
      required this.text,
      this.capitalization,
      this.onChanged,
      this.formatters,
      this.completed,
      this.icon,
      this.maxLines,
      this.maxLength,
      this.focusNode,
      this.password = false,
      this.autoFocus = false,
      this.readOnly = false,
      this.mandatory = true,
      this.type,
      this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      textCapitalization: capitalization ?? TextCapitalization.none,
      onEditingComplete: completed,
      inputFormatters: formatters ?? [],
      cursorColor: MyAppColors.darkGrey,
      style: MyAppTextStyles.textInput.copyWith(
          color: Colors.grey.shade200
        ),
      controller: controller,
      obscureText: password,
      readOnly: readOnly,
      maxLength: maxLength,
      autofocus: autoFocus,
      maxLines: maxLines ?? 1,
      keyboardType: type ?? TextInputType.text,
      decoration: InputDecoration(
        fillColor: color ?? Colors.white,
        filled: true,
        prefixIcon: icon,
        hintText: text,
        hintStyle: MyAppTextStyles.textInput.copyWith(
          color: Colors.grey.shade200
        ),
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff323238), width: 1.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff323238), width: 1.0),
          ),
      ),
      validator:(value) {
        if (!mandatory) {
          return null;
        }
        if (value!.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
