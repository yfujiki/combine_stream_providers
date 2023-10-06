import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CombinedValueAsyncNotifier extends AsyncNotifier<(int, int)> {
  @override
  FutureOr<(int, int)> build() {
    return (0, 0);
  }

  void updateWithError(Object error, StackTrace stackTrace) {
    state = AsyncError(error, stackTrace);
  }

  void updateLoading() {
    if (state is AsyncLoading) return;
    state = const AsyncLoading();
  }

  void updateA(int value) {
    switch (state) {
      case AsyncData():
        AsyncData currentState = state as AsyncData;
        state = AsyncData((value, currentState.value.$2));
        break;
      default:
        state = AsyncData((value, 0));
    }
  }

  void updateB(int value) {
    switch (state) {
      case AsyncData():
        AsyncData currentState = state as AsyncData;
        state = AsyncData((currentState.value.$1, value));
        break;
      default:
        state = AsyncData((0, value));
    }
  }
}
