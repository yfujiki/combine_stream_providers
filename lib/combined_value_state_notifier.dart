import 'dart:async';

import 'package:combine_stream_providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CombinedValueAsyncNotifier extends AsyncNotifier<(int, int)?> {
  @override
  FutureOr<(int, int)?> build() {
    debugPrint("rebuilding...");
    final asyncValueA = ref.watch(streamProviderA);
    final asyncValueB = ref.watch(streamProviderB);

    asyncValueA.when(
        data: (value) {
          debugPrint("new data for stream A: $value");
          state = AsyncData(updateA(value));
        },
        error: (error, stackTrace) {
          throw error;
        },
        loading: () {});

    asyncValueB.when(
        data: (value) {
          debugPrint("new data for stream B: $value");
          state = AsyncData(updateB(value));
        },
        error: (error, stackTrace) {
          throw error;
        },
        loading: () {});

    if (state.asData == null) {
      // means that both streams are still loading
      debugPrint("both streams are still loading");
      return null;
    }

    debugPrint("new data from rebuild: ${state.asData!.value}");
    return state.asData!.value;
  }

  (int, int) updateA(int value) {
    debugPrint("state before updateA: $state");
    final currentCombo = state.valueOrNull;
    if (currentCombo == null) {
      return (value, 0);
    } else {
      return (value, currentCombo.$2);
    }
  }

  (int, int) updateB(int value) {
    debugPrint("state before updateB: $state");
    final currentCombo = state.valueOrNull;
    if (currentCombo == null) {
      return (0, value);
    } else {
      return (currentCombo.$1, value);
    }
  }
}
