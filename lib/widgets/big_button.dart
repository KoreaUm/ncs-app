import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const BigButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(48, 48),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 26),
        label: Text(label),
      ),
    );
  }
}
