import 'package:flutter/material.dart';

import 'pages/app.dart';
import 'store.dart';

void main() async => runApp(WordsApp(store: await createStore()));
