import 'package:flutter_riverpod/flutter_riverpod.dart';

sealed class CombinedValueState {}

class CombinedValueStateData extends CombinedValueState {
  final List<int> values;

  CombinedValueStateData(this.values);
}

class CombinedValueStateLoading extends CombinedValueState {}

class CombinedValueStateError extends CombinedValueState {
  final Object error;
  final StackTrace stackTrace;

  CombinedValueStateError(this.error, this.stackTrace);
}

class CombinedValueStateNotifier extends StateNotifier<CombinedValueState> {
  CombinedValueStateNotifier() : super(CombinedValueStateLoading());

  void updateWithError(Object error, StackTrace stackTrace) {
    state = CombinedValueStateError(error, stackTrace);
  }

  void updateLoading() {
    if (state is CombinedValueStateLoading) return;
    state = CombinedValueStateLoading();
  }

  void updateA(int value) {
    if (state is CombinedValueStateData) {
      CombinedValueStateData currentState = state as CombinedValueStateData;
      currentState.values[0] = value;
      state = currentState;
    } else {
      state = CombinedValueStateData([value, 0]);
    }
  }

  void updateB(int value) {
    if (state is CombinedValueStateData) {
      CombinedValueStateData currentState = state as CombinedValueStateData;
      currentState.values[1] = value;
      state = currentState;
    } else {
      state = CombinedValueStateData([0, value]);
    }
  }
}
