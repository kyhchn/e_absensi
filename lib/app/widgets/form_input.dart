import 'package:e_absensi/app/core/themes/typography.dart';
import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final String? label;
  final String hint;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function(String)? onFieldSubmitted;
  final bool useDecorationLabel;
  const FormInput(
      {Key? key,
      this.label,
      required this.hint,
      required this.inputType,
      required this.controller,
      this.onFieldSubmitted,
      this.useDecorationLabel = false,
      this.validator,
      this.readOnly,
      this.suffixIcon})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null && widget.useDecorationLabel == false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 16),
                  Text(
                    widget.label!,
                    style: TypographyStyles.b2.semibold(),
                  ),
                  SizedBox(height: 8),
                ],
              )
            : const SizedBox(),
        TextFormField(
          validator: super.widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          controller: widget.controller,
          readOnly: widget.readOnly ?? false,
          keyboardType: widget.inputType,
          obscureText: widget.inputType == TextInputType.visiblePassword
              ? !isPasswordVisible
              : false,
          style: TypographyStyles.b3.semibold(color: Colors.grey.shade600),
          decoration: InputDecoration(
            label: widget.useDecorationLabel == true && widget.label != null
                ? Text(widget.label!)
                : null,
            hintText: widget.hint,
            suffixIcon: widget.suffixIcon ??
                (widget.inputType == TextInputType.visiblePassword
                    ? IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: togglePasswordVisibility,
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
