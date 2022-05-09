import 'package:flutter_redux_sample/action/counter_action.dart';
import 'package:flutter_redux_sample/state/counter_state.dart';

CounterState counterReducer(CounterState state, action) {
  if (action is IncrementCounterAAction) {
    return CounterState(state.counterA + 1, state.counterB);
  } else if (action is DecrementCounterAAction) {
    return CounterState(state.counterA - 1, state.counterB);
  } else if (action is IncrementCounterBAction) {
    return CounterState(state.counterA, state.counterB + 1);
  } else if (action is DecrementCounterBAction) {
    return CounterState(state.counterA, state.counterB - 1);
  } else {
    return state;
  }
}