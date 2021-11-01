import 'package:flutter/material.dart';


class textData extends StatelessWidget {
  String info;
  bool toBold;
  double size;

  textData({required this.info, required this.toBold, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      info, style: TextStyle(
      fontSize: size,
      fontWeight: toBold?FontWeight.bold:FontWeight.normal,
    ),
    );
  }
}
