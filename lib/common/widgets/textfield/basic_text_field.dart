import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final bool? obscureText;

  const BasicTextField({
    super.key,
    required this.controller,
    required this.label,
    this.errorText,
    this.obscureText,
  });

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  late bool _obscureText ;
  @override
  void initState(){
    super.initState();
    _obscureText = widget.obscureText??false;
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: widget.controller,
      cursorColor: theme.primaryColor,
      obscureText: _obscureText??false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.primaryColor),
        ),
        label: Text(
          widget.label,
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.colorScheme.onPrimary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.colorScheme.onPrimary),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.colorScheme.onPrimary),
        ),
        errorText: widget.errorText,
        suffixIcon:
        widget.obscureText != null
                ? IconButton(
                  icon: Icon(_obscureText == true ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() {
                    _obscureText = !_obscureText;
                  }),
                )
                : null,
      ),
    );
  }
}
