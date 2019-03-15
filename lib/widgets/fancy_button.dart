import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  FancyButton(
    this.label, {
    this.icon,
    this.onTap,
    this.iconColor = Colors.white,
    this.labelColor = Colors.white,
  });

  final GestureTapCallback onTap;
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RawMaterialButton(
      shape: const StadiumBorder(),
      fillColor: theme.accentColor,
      splashColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 18, 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: iconColor,
              size: 32,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                fontSize: 18,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
      onPressed: onTap,
    );
  }
}
