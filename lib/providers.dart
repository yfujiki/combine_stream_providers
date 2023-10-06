import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'combined_value_state_notifier.dart';

final streamProviderA = StreamProvider<int>((ref) async* {
  yield* Stream.periodic(const Duration(seconds: 2), (index) => index);
});

final streamProviderB = StreamProvider<int>((ref) async* {
  yield* Stream.periodic(const Duration(seconds: 3), (index) => index);
});

final combinedValueNotifierProvider =
    AsyncNotifierProvider<CombinedValueAsyncNotifier, (int, int)>(
        CombinedValueAsyncNotifier.new);

final combinedValueProvider = Provider.autoDispose((ref) {
  final asyncValueA = ref.watch(streamProviderA);
  final asyncValueB = ref.watch(streamProviderB);

  CombinedValueAsyncNotifier notifier =
      ref.read(combinedValueNotifierProvider.notifier);

  asyncValueA.when(data: (value) {
    notifier.updateA(value);
  }, error: (error, stackTrace) {
    notifier.updateWithError(error, stackTrace);
  }, loading: () {
    notifier.updateLoading();
  });

  asyncValueB.when(data: (value) {
    notifier.updateB(value);
  }, error: (error, stackTrace) {
    notifier.updateWithError(error, stackTrace);
  }, loading: () {
    notifier.updateLoading();
  });

  return notifier;
});
