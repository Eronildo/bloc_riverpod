import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:riverpod/riverpod.dart';

// ignore: implementation_imports
import 'package:riverpod/src/framework.dart';

import 'builders.dart';

part 'bloc_provider/base.dart';
part 'bloc_provider/auto_dispose.dart';

/// {@template bloc_riverpod.blocprovider}
/// Creates a [Bloc] and subscribes to it.
/// {@endtemplate}
mixin _BlocProviderStateMixin<T extends BlocBase<dynamic>?>
    on ProviderStateBase<T, T> {
  StreamSubscription<dynamic>? subs;

  @override
  void valueChanged({T? previous}) {
    if (createdValue == previous) {
      return;
    }
    subs?.cancel();
    previous?.close();
    exposedValue = createdValue;
    subs = createdValue?.stream.listen(_listener);
  }

  void _listener(dynamic state) {
    exposedValue = createdValue;
  }

  @override
  void dispose() {
    subs?.cancel();
    createdValue?.close();
    super.dispose();
  }
}

Override _overrideWithValue<T extends BlocBase<dynamic>>(
  ProviderBase provider,
  T value,
) {
  return ProviderOverride(
    ValueProvider<T, T>((ref) {
      StreamSubscription<dynamic>? subs;

      void listen(T value) {
        subs?.cancel();
        // ignore: invalid_use_of_protected_member
        subs = value.stream.listen((dynamic state) => ref.markDidChange());
      }

      listen(value);
      ref.onChange = listen;

      ref.onDispose(() {
        subs?.cancel();
        value.close();
      });
      return value;
    }, value),
    provider,
  );
}
