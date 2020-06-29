import 'package:flutter/material.dart';
import 'package:thesisgisproject/components/text_field_container.dart';
import 'package:thesisgisproject/constants.dart';

class RoundedRepeatPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedRepeatPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Repeat Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
