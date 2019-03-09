library store;

export 'store/actions.dart';
export 'store/state.dart' show AppState;

import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'store/state.dart';
import 'store/reducers.dart';
import 'store/middlewares.dart';
import 'store/actions.dart';

Future<Store<AppState>> createStore() async {
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromPersistedJson),
  );

  final loadedInitialState = await persistor.load();

  final store = Store<AppState>(
    appReducers,
    initialState: loadedInitialState ?? AppState.initial(),
    middleware: [appMiddleware, persistor.createMiddleware()],
  );

  // fetch lessons if initialState is null
  // e.g., first install of app or user cleared data
  if (loadedInitialState.lessons.length == 0) {
    store.dispatch(FetchLessonsAction());
  }

  return store;
}
