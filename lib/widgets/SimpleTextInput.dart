import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleTextInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final Function value;

  SimpleTextInput(
      {@required this.hintText,
      @required this.labelText,
      @required this.keyboardType,
      @required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onChanged: value,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }
}
