import 'package:flutter/material.dart';
import 'constants.dart';

class CryptoDisplayButtons extends StatelessWidget {
  const CryptoDisplayButtons(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: kButtonTextStyle,
        ),
      ),
    );
  }
}
