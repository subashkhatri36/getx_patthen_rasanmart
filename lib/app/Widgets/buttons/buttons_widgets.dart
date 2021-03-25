import 'package:flutter/material.dart';

class CustomeTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color color;
  CustomeTextButton({
    @required this.label,
    this.onPressed,
    this.color = Colors.amber,
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
        primary: Colors.white, // foreground/text
        backgroundColor: color, // background
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
