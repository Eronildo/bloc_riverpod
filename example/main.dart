import 'package:bloc_riverpod/bloc_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit(int state) : super(state);

  void increment() => emit(state + 1);
}

final counterProvider = BlocProvider.autoDispose
    // ignore: avoid_types_on_closure_parameters
    .family((ref, int initialCounter) => CounterCubit(initialCounter));

void main() {
  final container = ProviderContainer();
  // Access the bloc directly
  final counterCubit = container.read(counterProvider(0));

  counterCubit.increment();
  counterCubit.increment();

  // Prints '2'
  // ignore: avoid_print
  print(counterCubit.state);

  container.dispose();
}
