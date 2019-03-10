import 'package:flutter/material.dart';

import 'words/app.dart';
import 'store.dart';

void main() async => runApp(WordsApp(store: await createStore()));
