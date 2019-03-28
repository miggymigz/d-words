import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:chinese_words/core/localizations.dart';
import 'package:chinese_words/components/components.dart';
import 'package:chinese_words/store/store.dart';
import 'package:chinese_words/viewmodels/viewmodels.dart';

class HiddenLessonsScreen extends StatelessWidget {
  const HiddenLessonsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final localizations = AppLocalizations.of(context).hiddenLessons;

    return AppBar(
      title: Text(
        localizations.title,
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontFamily: 'GoogleSans',
          fontWeight: FontWeight.w700,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Theme.of(context).accentColor),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StoreConnector<AppState, LessonListVM>(
      converter: (store) => LessonListVM.from(
            store,
            selector: hiddenCollectionsSelector,
          ),
      builder: (context, vm) => LessonList(
            collections: vm.collections,
            isLoading: vm.isLoading,
          ),
    );
  }
}
