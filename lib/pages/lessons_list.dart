import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:chinese_words/analytics.dart' as analytics;
import 'package:chinese_words/localizations.dart';
import 'package:chinese_words/helpers.dart' as helper;
import 'package:chinese_words/models.dart';
import 'package:chinese_words/store.dart';
import 'package:chinese_words/widgets.dart';

import 'words_list.dart';
import 'quiz_settings.dart';

class LessonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final localizations = AppLocalizations.of(context).lessons;
    final accentColor = Theme.of(context).accentColor;

    return AppBar(
      title: Text(
        localizations.title,
        style: TextStyle(
          fontFamily: 'GoogleSans',
          fontWeight: FontWeight.w700,
          color: accentColor,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.blueAccent),
      actions: [
        _buildAppBarRefreshAction(),
        _buildOverflowMenu(context),
      ],
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
              ..showSnackBar(SnackBar(
                content: Text(localizations.lblUpdatingLessons),
                duration: Duration(seconds: 1),
              ));

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
      onSelected: (value) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HiddenLessonsList(
                    collectionHeaderBuilder: _buildCollectionHeader,
                    lessonRowBuilder: _buildLessonRow,
                  ),
            ),
          ),
      itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(localizations.overflowLblHiddenLessons),
              value: 'hidden lessons',
            ),
          ],
    );
  }

  Widget _buildBody() {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        if (state.collections.length == 0) {
          return Center(child: CircularProgressIndicator());
        }

        final collections = state.collections;
        final hiddenLessonIds = state.hiddenLessonIds;
        final items = helper.createListItems(collections,
            includeCollection: (collection) => collection.lessons
                .any((lesson) => !hiddenLessonIds.contains(lesson.id)),
            includeLesson: (lesson) => !hiddenLessonIds.contains(lesson.id));

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, i) {
            final collectionIndex = items[i][0];
            final collection = collections[collectionIndex];

            // header row
            if (items[i][1] == null) {
              return _buildCollectionHeader(collection);
            }

            final lessonIndex = items[i][1];
            final lesson = collection.lessons[lessonIndex];
            return _buildLessonRow(context, lesson, lessonIndex);
          },
        );
      },
    );
  }

  Widget _buildCollectionHeader(Collection collection) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        collection.name,
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget _buildLessonRow(BuildContext context, Lesson lesson, int index) {
    return ListTile(
      key: Key(lesson.title),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Text(
          (index + 1).toString(),
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      title: Text(lesson.title),
      subtitle: Text(lesson.subtitle),
      onTap: () {
        final title = '${lesson.title}：${lesson.subtitle}';

        analytics.lessonViewed(lesson: lesson);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordsList(title: title, lesson: lesson),
          ),
        );
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    final localizations = AppLocalizations.of(context).lessons;

    return FancyButton(
      localizations.btnStartTest,
      icon: Icons.explore,
      onTap: () {
        // update TTS state
        StoreProvider.of<AppState>(context)
            .dispatch(CheckTtsAvailabilityAction());

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => QuizSettings()));
      },
    );
  }
}

typedef CollectionHeaderBuilder = Widget Function(Collection);
typedef LessonRowBuilder = Widget Function(BuildContext, Lesson, int);

class HiddenLessonsList extends StatelessWidget {
  HiddenLessonsList({
    @required this.collectionHeaderBuilder,
    @required this.lessonRowBuilder,
  });

  final CollectionHeaderBuilder collectionHeaderBuilder;
  final LessonRowBuilder lessonRowBuilder;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context).hiddenLessons;

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          final localizations = AppLocalizations.of(context).hiddenLessons;
          final collections = state.collections;
          final hiddenLessonIds = state.hiddenLessonIds;

          if (hiddenLessonIds.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.book,
                    size: 64,
                    color: Colors.white30,
                  ),
                  SizedBox(height: 24),
                  Text(
                    localizations.lblNoHiddenLessons,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 24,
                      fontFamily: 'GoogleSans',
                    ),
                  ),
                ],
              ),
            );
          }

          final items = helper.createListItems(collections,
              includeCollection: (collection) => collection.lessons
                  .any((lesson) => hiddenLessonIds.contains(lesson.id)),
              includeLesson: (lesson) => hiddenLessonIds.contains(lesson.id));

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final collectionIndex = items[i][0];
              final collection = collections[collectionIndex];

              // header row
              if (items[i][1] == null) {
                return collectionHeaderBuilder(collection);
              }

              final lessonIndex = items[i][1];
              final lesson = collection.lessons[lessonIndex];
              return lessonRowBuilder(context, lesson, lessonIndex);
            },
          );
        },
      ),
    );
  }
}
