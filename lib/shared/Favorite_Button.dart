import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  final IconData icon;
  final Color color;

  const FavoriteButton(
      {Key key, this.onPressed, this.size, this.color, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
