import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    Key? key,
    required this.label,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.initialValue,
    this.enabled = true,
    this.inputFormatters,
    this.onTap,
    this.obsureText = false,
    this.suffixIcon,
  }) : super(key: key);
  final String label;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool readOnly, enabled;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;

  final bool obsureText;

  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      enabled: enabled,
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      initialValue: initialValue,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obsureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: appColor,
        
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: secondaryColor, width: 2),
        ),
      ),
    );
  }
}
