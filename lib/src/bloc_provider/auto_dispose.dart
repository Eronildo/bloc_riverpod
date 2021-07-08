part of '../bloc_provider.dart';

/// {@macro bloc_riverpod.blocprovider}
@sealed
class AutoDisposeBlocProvider<T extends BlocBase<dynamic>>
    extends AutoDisposeProviderBase<T, T>
    with AutoDisposeProviderOverridesMixin<T, T> {
  /// {@macro bloc_riverpod.blocprovider}
  AutoDisposeBlocProvider(
    this._create, {
    String? name,
  }) : super(name);

  /// {@macro bloc_riverpod.family}
  static const family = BlocProviderFamilyBuilder();

  /// {@macro bloc_riverpod.blocprovider.bloc}
  late final AutoDisposeProviderBase<T, T> bloc =
      AutoDisposeProvider((ref) => ref.watch(this));

  @override
  Override overrideWithValue(T value) => _overrideWithValue(this, value);

  final Create<T, AutoDisposeProviderReference> _create;

  @override
  T create(covariant AutoDisposeProviderReference ref) {
    return _create(ref);
  }

  @override
  _AutoDisposeBlocProviderState<T> createState() =>
      _AutoDisposeBlocProviderState();
}

@sealed
class _AutoDisposeBlocProviderState<
        T extends BlocBase<dynamic>> = ProviderStateBase<T, T>
    with _BlocProviderStateMixin<T>;

/// {@macro bloc_riverpod.blocprovider.family}
@sealed
class AutoDisposeBlocProviderFamily<T extends BlocBase<dynamic>, A>
    extends Family<T, T, A, AutoDisposeProviderReference,
        AutoDisposeBlocProvider<T>> {
  /// {@macro bloc_riverpod.blocprovider.family}
  AutoDisposeBlocProviderFamily(
    T Function(AutoDisposeProviderReference ref, A a) create, {
    String? name,
  }) : super(create, name);

  @override
  AutoDisposeBlocProvider<T> create(
    A value,
    T Function(AutoDisposeProviderReference ref, A param) builder,
    String? name,
  ) {
    return AutoDisposeBlocProvider(
      (ref) => builder(ref, value),
      name: name,
    );
  }
}
