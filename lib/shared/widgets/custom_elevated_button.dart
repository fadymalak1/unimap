import 'package:flutter/material.dart';
import 'package:unimap/config/themes.dart';

class CustomElevatedButton extends ElevatedButton {
  CustomElevatedButton({
    super.key,
    required super.onPressed,
    required super.child,
  }) : super(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(double.infinity, 50),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }