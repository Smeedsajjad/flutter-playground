import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final dynamic iconsColor;
  final String title;
  final String value;
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.iconsColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconsColor),
        Text(title),
        Text(value),
      ],
    );
  }
}
