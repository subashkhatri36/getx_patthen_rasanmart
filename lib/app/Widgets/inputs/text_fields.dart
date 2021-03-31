import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';

class InputField extends StatelessWidget {
  const InputField(
      {@required this.context,
      this.label,
      this.hintText,
      this.obscureText,
      this.textInputType,
      this.icon,
      this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.iconColor,
      this.textFieldColor,
      this.controller,
      this.borderColor = Colors.white,
      this.autovalidateMode});

  final IconData icon;
  final String hintText;
  final TextInputType textInputType;
  final Color textFieldColor, iconColor, borderColor;
  final bool obscureText;
  final validator;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final String label;
  final controller;
  final autovalidateMode;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.only(
          bottom: Defaults.defaultPadding / 2,
          top: Defaults.defaultPadding / 2),
      child: TextFormField(
        controller: controller ?? null,
        autovalidateMode:
            autovalidateMode ?? AutovalidateMode.onUserInteraction,
        style: TextStyle(color: Theme.of(context).primaryColor),
        decoration: new InputDecoration(
          //contentPadding: EdgeInsets.all(default),
          border: buildOutlineInputBorder(context),
          enabledBorder: buildOutlineInputBorder(context),

          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[300], width: 1),
              borderRadius: BorderRadius.circular(Defaults.defaultfontsize)),
          prefixIcon: icon != null ? new Icon(icon) : null,
          labelText: label ?? "",
          labelStyle: TextStyle(color: Colors.white),
          hintText: hintText ?? "",
          errorStyle: TextStyle(color: Colors.white),
          hintStyle: const TextStyle(
              color: Colors.white, fontSize: Defaults.defaultfontsize),
        ),
        validator: validator ?? null,
        onFieldSubmitted: onFieldSubmitted ?? null,
        onChanged: onChanged ?? null,
        obscureText: obscureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
      ),
    ));
  }

  OutlineInputBorder buildOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        borderRadius: BorderRadius.circular(Defaults.defaultfontsize));
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.controller,
    this.texttype,
    @required this.lable,
    @required this.hinttext,
    this.validator,
    this.onFieldSubmitted,
    this.icon,
    this.errortext,
    this.focus = false,
  }) : super(key: key);

  final controller;
  final texttype;
  final String lable;
  final String hinttext;
  final validator;
  final onFieldSubmitted;
  final IconData icon;
  final String errortext;
  final bool focus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Theme.of(context).backgroundColor),
      keyboardType: texttype ?? TextInputType.text,
      validator: validator ?? null,
      onFieldSubmitted: onFieldSubmitted ?? null,
      autofocus: focus,
      decoration: new InputDecoration(
        prefixIcon: icon != null
            ? new Icon(
                icon,
                color: Theme.of(context).backgroundColor,
              )
            : null,
        //contentPadding: EdgeInsets.all(default),
        border: newbuildOutlineInputBorder(context),
        enabledBorder: newbuildOutlineInputBorder(context),
        focusColor: Theme.of(context).backgroundColor,

        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow[300], width: 1),
            borderRadius: BorderRadius.circular(Defaults.defaultfontsize)),

        labelText: lable,
        labelStyle: TextStyle(color: Theme.of(context).backgroundColor),
        hintText: hinttext,
        errorStyle: TextStyle(color: Colors.red),
        errorText: errortext,
        hintStyle: const TextStyle(
            color: Color(0xFFD32F2F), fontSize: Defaults.defaultfontsize),
      ),
    );
  }
}

OutlineInputBorder newbuildOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).backgroundColor, width: 1),
      borderRadius: BorderRadius.circular(Defaults.defaultfontsize));
}
