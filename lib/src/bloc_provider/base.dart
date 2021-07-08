part of '../bloc_provider.dart';

/// {@macro bloc_riverpod.blocprovider}
@sealed
class BlocProvider<T extends BlocBase<dynamic>>
    extends AlwaysAliveProviderBase<T, T> with ProviderOverridesMixin<T, T> {
  /// {@macro bloc_riverpod.blocprovider}
  BlocProvider(this._create, {String? name}) : super(name);

  /// {@macro bloc_riverpod.family}
  static const family = BlocProviderFamilyBuilder();

  /// {@macro bloc_riverpod.autoDispose}
  static const autoDispose = AutoDisposeBlocProviderBuilder();

  /// {@template bloc_riverpod.blocprovider.bloc}
  /// Obtains the [Bloc] associated with this provider, but without
  /// listening to it.
  ///
  /// Listening to this provider may cause providers/widgets to rebuild in the
  /// event that the [Bloc] it recreated.
  ///
  ///
  /// It is preferrable to do:
  /// ```dart
  /// ref.watch(blocProvider.bloc)
  /// ```
  ///
  /// instead of:
  /// ```dart
  /// ref.read(blocProvider)
  /// ```
  ///
  /// The reasoning is, using `read` could cause hard to catch bugs, such as
  /// not rebuilding dependent providers/widgets after using `context.refresh` on this provider.
  /// {@endtemplate}
  late final AlwaysAliveProviderBase<T, T> bloc =
      Provider((ref) => ref.watch(this));

  @override
  Override overrideWithValue(T value) => _overrideWithValue(this, value);

  final Create<T, ProviderReference> _create;

  @override
  T create(ProviderReference ref) => _create(ref);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState();
}

@sealed
class _BlocProviderState<T extends BlocBase<dynamic>> = ProviderStateBase<T, T>
    with _BlocProviderStateMixin<T>;

/// {@template bloc_riverpod.blocprovider.family}
/// A class that allows building a [BlocProvider] from an external parameter.
/// {@endtemplate}
@sealed
class BlocProviderFamily<T extends BlocBase<dynamic>, A>
    extends Family<T, T, A, ProviderReference, BlocProvider<T>> {
  /// {@macro bloc_riverpod.blocprovider.family}
  BlocProviderFamily(
    T Function(ProviderReference ref, A a) create, {
    String? name,
  }) : super(create, name);

  @override
  BlocProvider<T> create(
    A value,
    T Function(ProviderReference ref, A param) builder,
    String? name,
  ) {
    return BlocProvider((ref) => builder(ref, value), name: name);
  }
}
