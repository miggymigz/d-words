import 'package:flutter/material.dart';

import 'package:chinese_words/models/models.dart';

class CollectionHeader extends StatelessWidget {
  const CollectionHeader({this.collection, Key key}) : super(key: key);

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        collection.name,
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
