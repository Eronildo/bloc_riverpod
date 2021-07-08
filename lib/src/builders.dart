import 'package:bloc/bloc.dart';

// ignore: implementation_imports
import 'package:riverpod/src/framework.dart';

import 'bloc_provider.dart';

/// Builds a [BlocProviderFamily].
class BlocProviderFamilyBuilder {
  /// Builds a [BlocProviderFamily].
  const BlocProviderFamilyBuilder();

  /// {@macro bloc_riverpod.family}
  BlocProviderFamily<B, Param> call<B extends BlocBase<dynamic>, Param>(
    B Function(ProviderReference ref, Param param) create, {
    String? name,
  }) {
    return BlocProviderFamily(create, name: name);
  }

  /// {@macro bloc_riverpod.autoDispose}
  AutoDisposeBlocProviderFamilyBuilder get autoDispose {
    return const AutoDisposeBlocProviderFamilyBuilder();
  }
}

/// Builds a [AutoDisposeBlocProvider].
class AutoDisposeBlocProviderBuilder {
  /// Builds a [AutoDisposeBlocProvider].
  const AutoDisposeBlocProviderBuilder();

  /// {@macro bloc_riverpod.autoDispose}
  AutoDisposeBlocProvider<B> call<B extends BlocBase<dynamic>>(
    B Function(AutoDisposeProviderReference ref) create, {
    String? name,
  }) {
    return AutoDisposeBlocProvider(create, name: name);
  }

  /// {@macro bloc_riverpod.family}
  AutoDisposeBlocProviderFamilyBuilder get family {
    return const AutoDisposeBlocProviderFamilyBuilder();
  }
}

/// Builds a [AutoDisposeBlocProviderFamily].
class AutoDisposeBlocProviderFamilyBuilder {
  /// Builds a [AutoDisposeBlocProviderFamily].
  const AutoDisposeBlocProviderFamilyBuilder();

  /// {@macro bloc_riverpod.family}
  AutoDisposeBlocProviderFamily<B, Param>
      call<B extends BlocBase<dynamic>, Param>(
    B Function(AutoDisposeProviderReference ref, Param param) create, {
    String? name,
  }) {
    return AutoDisposeBlocProviderFamily(create, name: name);
  }
}
