import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Stream<int> streamA(Ref ref) {
  return Stream.periodic(const Duration(seconds: 2), (index) => index + 1);
}

@riverpod
Stream<int> streamB(Ref ref) {
  return Stream.periodic(const Duration(seconds: 3), (index) => index + 1);
}

