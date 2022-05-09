import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_sample/action/counter_action.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_sample/reducer/root_reducer.dart';
import 'package:flutter_redux_sample/state/counter_state.dart';
import 'package:flutter_redux_sample/state/root_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Redux Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoreProvider(
          store: Store<RootState>(
            rootReducer,
            initialState: RootState(CounterState(0, 0)),
          ),
          child: const MyHomePage(title: 'Redux Sample'),
        )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, @required this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreBuilder<RootState>(
              builder: (context, store) {
                return WidgetA(store.state.counterState.counterA);
                },
            ),
            StoreConnector<RootState, int>(
              converter: (store) => store.state.counterState.counterB,
              distinct: true,
              builder: (context, counterB) {
                return WidgetB(counterB);
              },
            ),
            StoreConnector<RootState, VoidCallback>(
              converter: (store) => () => store.dispatch(IncrementCounterAAction()),
              builder: (context, dispatchIncrement) {
                return ElevatedButton(
                    onPressed: dispatchIncrement,
                    child: const Text(
                        'Increment Count A',
                        style: TextStyle(
                            fontSize: 20
                        )
                    )
                );
              },
            ),
            StoreConnector<RootState, VoidCallback>(
              converter: (store) => () => store.dispatch(DecrementCounterAAction()),
              builder: (context, dispatchIncrement) {
                return ElevatedButton(
                    onPressed: dispatchIncrement,
                    child: const Text(
                        'Decrement Count A',
                        style: TextStyle(
                            fontSize: 20
                        )
                    )
                );
              },
            ),
            StoreConnector<RootState, VoidCallback>(
              converter: (store) => () => store.dispatch(IncrementCounterBAction()),
              builder: (context, dispatchIncrement) {
                return ElevatedButton(
                    onPressed: dispatchIncrement,
                    child: const Text(
                        'Increment Count B',
                        style: TextStyle(
                            fontSize: 20
                        )
                    )
                );
              },
            ),
            StoreConnector<RootState, VoidCallback>(
              converter: (store) => () => store.dispatch(DecrementCounterBAction()),
              builder: (context, dispatchIncrement) {
                return ElevatedButton(
                    onPressed: dispatchIncrement,
                    child: const Text(
                        'Decrement Count B',
                        style: TextStyle(
                            fontSize: 20
                        )
                    )
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  final int counter;
  const WidgetA(this.counter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build WidgetA');
    return Text(
        'CounterA: '+ counter.toString(),
        style: const TextStyle(
        fontSize: 24
        )
    );
  }
}

class WidgetB extends StatelessWidget {
  final int counter;
  const WidgetB(this.counter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build WidgetB');
    return Text(
        'CounterB: '+ counter.toString(),
        style: const TextStyle(
            fontSize: 24
        )
    );
  }
}