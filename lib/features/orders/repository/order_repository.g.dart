// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRepositoryHash() => r'636612c3362c455a2ef2b8ce28f5320244a2b3c0';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = Provider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderRepositoryRef = ProviderRef<OrderRepository>;
String _$getGuestOrdersHash() => r'f894c7846ef87ad31e099367211810659c4282cc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getGuestOrders].
@ProviderFor(getGuestOrders)
const getGuestOrdersProvider = GetGuestOrdersFamily();

/// See also [getGuestOrders].
class GetGuestOrdersFamily extends Family<AsyncValue<List<UserOrder>>> {
  /// See also [getGuestOrders].
  const GetGuestOrdersFamily();

  /// See also [getGuestOrders].
  GetGuestOrdersProvider call({
    required String phone,
  }) {
    return GetGuestOrdersProvider(
      phone: phone,
    );
  }

  @override
  GetGuestOrdersProvider getProviderOverride(
    covariant GetGuestOrdersProvider provider,
  ) {
    return call(
      phone: provider.phone,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getGuestOrdersProvider';
}

/// See also [getGuestOrders].
class GetGuestOrdersProvider
    extends AutoDisposeFutureProvider<List<UserOrder>> {
  /// See also [getGuestOrders].
  GetGuestOrdersProvider({
    required String phone,
  }) : this._internal(
          (ref) => getGuestOrders(
            ref as GetGuestOrdersRef,
            phone: phone,
          ),
          from: getGuestOrdersProvider,
          name: r'getGuestOrdersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getGuestOrdersHash,
          dependencies: GetGuestOrdersFamily._dependencies,
          allTransitiveDependencies:
              GetGuestOrdersFamily._allTransitiveDependencies,
          phone: phone,
        );

  GetGuestOrdersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.phone,
  }) : super.internal();

  final String phone;

  @override
  Override overrideWith(
    FutureOr<List<UserOrder>> Function(GetGuestOrdersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetGuestOrdersProvider._internal(
        (ref) => create(ref as GetGuestOrdersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        phone: phone,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserOrder>> createElement() {
    return _GetGuestOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetGuestOrdersProvider && other.phone == phone;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phone.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetGuestOrdersRef on AutoDisposeFutureProviderRef<List<UserOrder>> {
  /// The parameter `phone` of this provider.
  String get phone;
}

class _GetGuestOrdersProviderElement
    extends AutoDisposeFutureProviderElement<List<UserOrder>>
    with GetGuestOrdersRef {
  _GetGuestOrdersProviderElement(super.provider);

  @override
  String get phone => (origin as GetGuestOrdersProvider).phone;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
