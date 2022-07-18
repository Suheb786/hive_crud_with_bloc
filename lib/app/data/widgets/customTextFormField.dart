import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  bool obscureText;
  final Widget? prefixIcon;
  final String? labelText;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  void Function()? onTap;
  AutovalidateMode? autoValid;
  Color borderColor;
  int? maxLength;
  Color fillColor;
  Color textColor;
  Color errorColor;
  Color focusedBorder;
  bool isDense;
  bool readOnly;

  final String? hintText;
  CustomTextField({
    this.readOnly = false,
    this.isDense = true,
    this.focusedBorder = Colors.transparent,
    this.errorColor = Colors.white,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.fillColor = Colors.transparent,
    this.obscureText = false,
    this.prefixIcon,
    this.maxLines = 1,
    this.suffixIcon,
    this.maxLength,
    this.autoValid,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType,
    this.validator,
    this.labelText,
    this.controller,
    this.onTap,
    Key? key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6.0,
        bottom: 6.0,
      ),
      child: TextFormField(
        readOnly: readOnly,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: maxLines,
        textCapitalization: textCapitalization,
        onTap: onTap,
        maxLength: maxLength,
        autovalidateMode: autoValid,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        cursorHeight: 17,
        cursorColor: textColor,
        style: TextStyle(
          fontFamily: "Gotham",
          color: textColor,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,

          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(color: Color.fromARGB(255, 195, 203, 195)),
          filled: true,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              color: borderColor,
              width: 2,
            ),
          ),
          // isDense: isDense,
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: "Gotham",
            color: textColor,
            fontSize: 14,
          ),
          fillColor: fillColor,
          focusedBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              color: focusedBorder,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              color: borderColor,
              width: 1.5,
            ),
          ),
          errorStyle: TextStyle(color: textColor, fontSize: 10),
          errorBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              color: errorColor,
              width: 2,
            ),
          ),
          // errorStyle: GoogleFonts.montserrat(
          //     fontSize: 10, color: Colors.white.withOpacity(0.75)),
        ),
      ),
    );
  }
}
