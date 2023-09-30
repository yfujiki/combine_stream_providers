import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final streamProviderA = StreamProvider<int>((ref) async* {
  yield* Stream.periodic(const Duration(seconds: 2), (index) => index);
});

final streamProviderB = StreamProvider<int>((ref) async* {
  yield* Stream.periodic(const Duration(seconds: 3), (index) => index);
});

final combinedStreamProvider = StreamProvider.autoDispose<List<int>>((ref) {
  final streamA = ref.watch(streamProviderA.stream);
  final streamB = ref.watch(streamProviderB.stream);

  return Rx.combineLatest2(streamA, streamB, (a, b) => [a, b]);
});
