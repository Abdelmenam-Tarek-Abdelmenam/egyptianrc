import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultFilledButton extends StatelessWidget {
  const DefaultFilledButton(
      {required this.title, required this.onPressed, Key? key})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            fixedSize: const Size(255, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            textStyle: GoogleFonts.notoSansArabic(
                fontWeight: FontWeight.bold, fontSize: 18),
            side: BorderSide.none),
        onPressed: onPressed,
        child: Text(title));
  }
}

class DefaultOutlinedButton extends StatelessWidget {
  const DefaultOutlinedButton(
      {required this.title, required this.onPressed, Key? key})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          fixedSize: const Size(255, 55),
          side: BorderSide(
              width: 1.5, color: Theme.of(context).colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          textStyle: GoogleFonts.notoSansArabic(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        onPressed: onPressed,
        child: Text(title));
  }
}
