# Bloc Riverpod - BlocProvider

It's similar to `ChangeNotifierProvider` but with bloc instead of ChangeNotifier.

```dart
import 'package:flutter/material.dart';
import 'package:bloc_riverpod/bloc_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit(int state) : super(state);

  void increment() => emit(state + 1);
}

final counterProvider = BlocProvider((ref) => CounterCubit(0));

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Rebuilds the widget if the cubit/bloc's state changes.
    final counterCubit = watch(counterProvider);
    return Scaffold(
      body: Center(
        child: Text(
          '${counterCubit.state}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterCubit.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```
