import 'package:flutter_redux_sample/reducer/counter_reducer.dart';
import 'package:flutter_redux_sample/state/root_state.dart';

RootState rootReducer(RootState state, action) {
  return RootState(counterReducer(state.counterState, action));
}