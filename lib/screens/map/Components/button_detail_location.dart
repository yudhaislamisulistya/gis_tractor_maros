import 'package:flutter/material.dart';

class ButtonDetailLocation extends StatelessWidget {
  final IconData icon;
  final Color color;

  ButtonDetailLocation({this.icon, this.color});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      elevation: 2.0,

      fillColor: Colors.white,
      child: new Icon(
        icon,
        color: color,
      ),
      shape: CircleBorder(),
    );
  }
}
