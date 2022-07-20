import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InkWell SaveButton(
    {required BuildContext context,
    Function()? onTap,
    Color? color,
    String text = "SAVE",
    Color? fontColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
      child: Center(
        child: Text(text,
            style: GoogleFonts.montserrat(
                fontSize: 18, color: fontColor, fontWeight: FontWeight.bold)),
      ),
    ),
  );
}
