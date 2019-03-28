import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:chinese_words/core/analytics.dart' as analytics;
import 'package:chinese_words/core/keys.dart';
import 'package:chinese_words/core/localizations.dart';
import 'package:chinese_words/core/routes.dart';
import 'package:chinese_words/store/store.dart';
import 'package:chinese_words/widgets/widgets.dart';
import 'package:chinese_words/components/components.dart';
import 'package:chinese_words/viewmodels/viewmodels.dart';

class LessonsScreen extends StatefulWidget {
  LessonsScreen({@required this.onInit}) : super(key: DWordsKeys.lessons);

  final VoidCallback onInit;

  @override
  _LessonsScreenState createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildAppBar() {
    final localizations = AppLocalizations.of(context).lessons;
    final accentColor = Theme.of(context).accentColor;

    return AppBar(
      actions: [
        _buildAppBarRefreshAction(),
        _buildOverflowMenu(context),
      ],
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.blueAccent),
      title: Text(
        localizations.title,
        style: TextStyle(
          fontFamily: 'GoogleSans',
          fontWeight: FontWeight.w700,
          color: accentColor,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return StoreConnector<AppState, LessonListVM>(
      converter: (store) => LessonListVM.from(
            store,
            selector: visibleCollectionsSelector,
          ),
      builder: (context, vm) => LessonList(
            collections: vm.collections,
            isLoading: vm.isLoading,
          ),
    );
  }

  Widget _buildFab() {
    final localizations = AppLocalizations.of(context).lessons;

    return FancyButton(
      localizations.btnStartTest,
      icon: Icons.explore,
      onTap: () {
        // update TTS state
        StoreProvider.of<AppState>(context)
            .dispatch(CheckTtsAvailabilityAction());

        Navigator.pushNamed(context, DWordsRoutes.quizSettings);
      },
    );
  }

  Widget _buildAppBarRefreshAction() {
    return Builder(
      builder: (context) {
        final localizations = AppLocalizations.of(context).lessons;

        return IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(localizations.lblUpdatingLessons),
                  duration: Duration(seconds: 1),
                ),
              );

            analytics.refreshTapped();
            StoreProvider.of<AppState>(context)
                .dispatch(FetchCollectionsAction());
          },
        );
      },
    );
  }

  Widget _buildOverflowMenu(BuildContext context) {
    final localizations = AppLocalizations.of(context).lessons;

    return PopupMenuButton(
      onSelected: (value) =>
          Navigator.pushNamed(context, DWordsRoutes.hiddenLessons),
      itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(localizations.overflowLblHiddenLessons),
              value: 'hidden lessons',
            ),
          ],
    );
  }
}
