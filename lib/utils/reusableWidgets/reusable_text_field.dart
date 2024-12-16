import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool isSearchField;
  final TextStyle? style;
  final Color? fillColor;
  final bool validateOnSubmit;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.isSearchField = false,
    this.style,
    this.fillColor,
    this.validateOnSubmit = true,
    this.maxLines,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;
  final _passwordValidator = PasswordValidator();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _validateField(String? value) {
    if (widget.validator != null) {
      return widget.validator!(value);
    }

    if (widget.isPassword) {
      return _passwordValidator.validate(
        value,
        validateOnSubmit: widget.validateOnSubmit,
      );
    }

    return null;
  }

  void _unFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      readOnly: widget.readOnly,
      style: widget.style ?? Theme.of(context).textTheme.bodyLarge,
      maxLines: widget.maxLines ?? 1,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
        Form.of(context).validate();
      },
      onFieldSubmitted: (_) => _unFocus(),
      onSaved: widget.onSaved,
      validator: _validateField,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor ?? Colors.white,
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            widget.isSearchField ? 20 : 10,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            widget.isSearchField ? 20 : 10,
          ),
          borderSide: BorderSide(
            color: widget.isSearchField
                ? Colors.white
                : Colors.grey.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            widget.isSearchField ? 20 : 10,
          ),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

class PasswordValidator {
  String? validate(String? value, {bool validateOnSubmit = true}) {
    if (value == null || value.isEmpty) {
      return validateOnSubmit ? "Password field cannot be blank." : null;
    }

    final requirements = [
      _RequirementCheck(
        check: (value) => value.length >= 8,
        message: "At least 8 characters",
      ),
      _RequirementCheck(
        check: (value) => value.contains(RegExp(r'[A-Z]')),
        message: "At least one uppercase letter",
      ),
      _RequirementCheck(
        check: (value) => value.contains(RegExp(r'[a-z]')),
        message: "At least one lowercase letter",
      ),
      _RequirementCheck(
        check: (value) => value.contains(RegExp(r'[@$!%*?&]')),
        message: "At least one special character (@\$!%*?&)",
      ),
    ];

    final failedRequirements = requirements
        .where((req) => !req.check(value))
        .map((req) => "• ${req.message}")
        .toList();

    if (failedRequirements.isNotEmpty) {
      return "Password must contain:\n${failedRequirements.join('\n')}";
    }

    return null;
  }
}

class _RequirementCheck {
  final bool Function(String) check;
  final String message;

  _RequirementCheck({
    required this.check,
    required this.message,
  });
}
