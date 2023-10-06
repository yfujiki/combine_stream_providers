import 'dart:async';

import 'package:combine_stream_providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CombinedValueAsyncNotifier extends AsyncNotifier<(int, int)> {
  @override
  FutureOr<(int, int)> build() {
    state = const AsyncLoading();

    final asyncValueA = ref.watch(streamProviderA);
    final asyncValueB = ref.watch(streamProviderB);

    asyncValueA.when(data: (value) {
      state = AsyncData(updateA(value));
    }, error: (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }, loading: () {
      state = const AsyncLoading();
    });

    asyncValueB.when(data: (value) {
      state = AsyncData(updateB(value));
    }, error: (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }, loading: () {
      state = const AsyncLoading();
    });

    if (state.asData == null) {
      state = const AsyncLoading();
      return (0, 0);
    }

    return state.asData!.value;
  }

  (int, int) updateA(int value) {
    switch (state) {
      case AsyncData():
        AsyncData currentState = state as AsyncData;
        return (value, currentState.value.$2);
      default:
        return (value, 0);
    }
  }

  (int, int) updateB(int value) {
    switch (state) {
      case AsyncData():
        AsyncData currentState = state as AsyncData;
        return (currentState.value.$1, value);
      default:
        return (0, value);
    }
  }
}
