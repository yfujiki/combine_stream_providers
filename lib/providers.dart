import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'combined_value_state_notifier.dart';

final streamProviderA = StreamProvider<int>((ref) async* {
  yield* Stream.periodic(const Duration(seconds: 2), (index) => index);
});

final streamProviderB = StreamProvider<int>((ref) async* {
  yield* Stream.periodic(const Duration(seconds: 3), (index) => index);
});

final combinedStateNotifierProvider = StateNotifierProvider.autoDispose<
    CombinedValueStateNotifier, CombinedValueState>((ref) {
  final asyncValueA = ref.watch(streamProviderA);
  final asyncValueB = ref.watch(streamProviderB);

  CombinedValueStateNotifier state = CombinedValueStateNotifier();

  asyncValueA.when(data: (value) {
    state.updateA(value);
  }, error: (error, stackTrace) {
    state.updateWithError(error, stackTrace);
  }, loading: () {
    state.updateLoading();
  });

  asyncValueB.when(data: (value) {
    state.updateB(value);
  }, error: (error, stackTrace) {
    state.updateWithError(error, stackTrace);
  }, loading: () {
    state.updateLoading();
  });

  return state;
});
