import 'package:flutter/material.dart';

class IconBoxCustom extends StatefulWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  const IconBoxCustom({
    this.backgroundColor = Colors.black,
    this.icon = Icons.flutter_dash,
    this.iconColor = Colors.white,

    super.key,
  });

  @override
  State<IconBoxCustom> createState() => _IconBoxCustomState();
}

class _IconBoxCustomState extends State<IconBoxCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      // height: 35,
      decoration: BoxDecoration(
        color: widget.backgroundColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20), // 🎯 Rounded corners
      ),

      child: FittedBox(
        child: Icon(widget.icon, color: widget.iconColor, size: 20),
      ),
    );
  }
}
