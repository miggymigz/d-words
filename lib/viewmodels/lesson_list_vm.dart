import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import 'package:chinese_words/store/store.dart';
import 'package:chinese_words/models/models.dart';

typedef HiddenShownCollectionsSelector = List<Collection> Function(
  List<Collection> rawCollections,
  Set<String> hiddenLessonIds,
);

class LessonListVM {
  const LessonListVM({
    @required this.collections,
    @required this.isLoading,
  });

  final List<Collection> collections;
  final bool isLoading;

  factory LessonListVM.from(
    Store<AppState> store, {
    HiddenShownCollectionsSelector selector,
  }) {
    final collections = selector == null
        ? collectionsSelector(store.state)
        : selector(
            collectionsSelector(store.state),
            hiddenLessonIdsSelector(store.state),
          );

    return LessonListVM(
      collections: collections,
      isLoading: isLoadingSelector(store.state),
    );
  }
}
