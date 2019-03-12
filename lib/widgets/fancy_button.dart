import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  FancyButton(this.label, {this.icon, this.onTap});

  final GestureTapCallback onTap;
  final IconData icon;
  final String label;

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
                  color: theme.accentIconTheme.color,
                  size: 32,
                ),
                SizedBox(width: 8),
                Text(label,
                    style: TextStyle(color: theme.primaryColor, fontSize: 16)),
              ],
            )),
        onPressed: onTap);
  }
}
