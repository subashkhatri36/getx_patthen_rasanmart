import 'package:flutter/material.dart';

class CustomeTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  CustomeTextButton({
    @required this.label,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: new Text(
        label,
        textAlign: TextAlign.center,
      ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: Colors.purple, // foreground/text
        backgroundColor: Colors.amber, // background
        // textStyle: TextStyle(
        //     fontSize: Constants.defaultFontSize, fontStyle: FontStyle.italic),
      ),
    );
  }
}

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    @required this.label,
    this.onPressed,
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: new Text(
        label,
        textAlign: TextAlign.center,
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.green, // background
        onPrimary: Colors.white, // foreground/text
        onSurface: Colors.grey, // disabled
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  CustomOutlinedButton({
    @required this.label,
    this.onPressed,
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: new Text(label, textAlign: TextAlign.center),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: Colors.white, // foreground
        onSurface: Colors.grey, // disabled
        backgroundColor: Colors.teal, // background
      ),
    );
  }
}
