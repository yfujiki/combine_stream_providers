import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'combined_value_state_notifier.dart';

final streamProviderA = StreamProvider<int>((ref) async* {
  yield* Stream.periodic(const Duration(seconds: 2), (index) => index);
});

final streamProviderB = StreamProvider<int>((ref) async* {
  yield* Stream.periodic(const Duration(seconds: 3), (index) => index);
});

final combinedValueNotifierProvider =
    AsyncNotifierProvider<CombinedValueAsyncNotifier, (int, int)?>(
        CombinedValueAsyncNotifier.new);
