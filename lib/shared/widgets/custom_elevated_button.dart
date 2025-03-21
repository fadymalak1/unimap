import 'package:flutter/material.dart';
import 'package:unimap/config/themes.dart';

class CustomElevatedButton extends ElevatedButton {
  CustomElevatedButton({
    super.key,
    required super.onPressed,
    required super.child,
    bool isOutlined = false,
  }) : super(
    style: ButtonStyle(
      elevation: isOutlined ? MaterialStateProperty.all<double>(0) : null,
      backgroundColor: isOutlined
          ? MaterialStateProperty.all<Color>(Colors.transparent)
          : MaterialStateProperty.all<Color>(AppTheme.primaryColor),
      foregroundColor: isOutlined
          ? MaterialStateProperty.all<Color>(AppTheme.primaryColor)
          : MaterialStateProperty.all<Color>(Colors.white),
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(double.infinity, 50),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppTheme.primaryColor, width: 2),
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
