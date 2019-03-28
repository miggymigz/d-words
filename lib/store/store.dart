library store;

export 'actions/actions.dart';
export 'reducers/reducers.dart';
export 'selectors/selectors.dart';

import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'reducers/reducers.dart';
import 'middlewares/middlewares.dart';

Future<Store<AppState>> createStore() async {
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromPersistedJson),
  );

  final loadedInitialState = await persistor.load();

  final store = Store<AppState>(
    appReducer,
    initialState: loadedInitialState ?? AppState.initial(),
    middleware: [epics, persistor.createMiddleware()],
  );

  return store;
}
