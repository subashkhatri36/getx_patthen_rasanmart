import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';

class CustomeTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color color;
  final Color fcolor;
  final IconData icon;
  CustomeTextButton({
    @required this.label,
    this.onPressed,
    this.color = Colors.amber,
    this.fcolor = Colors.white,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: icon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).backgroundColor,
                ),
                SizedBox(width: Defaults.defaultfontsize / 2),
                Expanded(
                  child: new Text(
                    label,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          : Text(
              label,
              textAlign: TextAlign.center,
            ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: fcolor, // foreground/text
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
