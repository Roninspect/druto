// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeRepositoryHash() => r'313dcdb2bafef6ceaeb0ad44dee236dfd590e1b3';

/// See also [homeRepository].
@ProviderFor(homeRepository)
final homeRepositoryProvider = Provider<HomeRepository>.internal(
  homeRepository,
  name: r'homeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HomeRepositoryRef = ProviderRef<HomeRepository>;
String _$getCategoriesHash() => r'5eb9c55d3aaf7e0a5e3826fa9c75d2badac8b9d4';

/// See also [getCategories].
@ProviderFor(getCategories)
final getCategoriesProvider = FutureProvider<List<ProductCategory>>.internal(
  getCategories,
  name: r'getCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCategoriesRef = FutureProviderRef<List<ProductCategory>>;
String _$getHubsHash() => r'a146b173098eb1493c2ca889a820490846f7aea1';

/// See also [getHubs].
@ProviderFor(getHubs)
final getHubsProvider = FutureProvider<List<Hub>>.internal(
  getHubs,
  name: r'getHubsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getHubsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetHubsRef = FutureProviderRef<List<Hub>>;
String _$getProductsByHubHash() => r'c892c52ce4bc43be4959da4a571d42d17f9fccc9';

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

/// See also [getProductsByHub].
@ProviderFor(getProductsByHub)
const getProductsByHubProvider = GetProductsByHubFamily();

/// See also [getProductsByHub].
class GetProductsByHubFamily extends Family<AsyncValue<List<ProductLine>>> {
  /// See also [getProductsByHub].
  const GetProductsByHubFamily();

  /// See also [getProductsByHub].
  GetProductsByHubProvider call({
    required int? cid,
    required int hid,
  }) {
    return GetProductsByHubProvider(
      cid: cid,
      hid: hid,
    );
  }

  @override
  GetProductsByHubProvider getProviderOverride(
    covariant GetProductsByHubProvider provider,
  ) {
    return call(
      cid: provider.cid,
      hid: provider.hid,
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
  String? get name => r'getProductsByHubProvider';
}

/// See also [getProductsByHub].
class GetProductsByHubProvider extends FutureProvider<List<ProductLine>> {
  /// See also [getProductsByHub].
  GetProductsByHubProvider({
    required int? cid,
    required int hid,
  }) : this._internal(
          (ref) => getProductsByHub(
            ref as GetProductsByHubRef,
            cid: cid,
            hid: hid,
          ),
          from: getProductsByHubProvider,
          name: r'getProductsByHubProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProductsByHubHash,
          dependencies: GetProductsByHubFamily._dependencies,
          allTransitiveDependencies:
              GetProductsByHubFamily._allTransitiveDependencies,
          cid: cid,
          hid: hid,
        );

  GetProductsByHubProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cid,
    required this.hid,
  }) : super.internal();

  final int? cid;
  final int hid;

  @override
  Override overrideWith(
    FutureOr<List<ProductLine>> Function(GetProductsByHubRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProductsByHubProvider._internal(
        (ref) => create(ref as GetProductsByHubRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cid: cid,
        hid: hid,
      ),
    );
  }

  @override
  FutureProviderElement<List<ProductLine>> createElement() {
    return _GetProductsByHubProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProductsByHubProvider &&
        other.cid == cid &&
        other.hid == hid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cid.hashCode);
    hash = _SystemHash.combine(hash, hid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetProductsByHubRef on FutureProviderRef<List<ProductLine>> {
  /// The parameter `cid` of this provider.
  int? get cid;

  /// The parameter `hid` of this provider.
  int get hid;
}

class _GetProductsByHubProviderElement
    extends FutureProviderElement<List<ProductLine>> with GetProductsByHubRef {
  _GetProductsByHubProviderElement(super.provider);

  @override
  int? get cid => (origin as GetProductsByHubProvider).cid;
  @override
  int get hid => (origin as GetProductsByHubProvider).hid;
}

String _$getPackagesByHubIdHash() =>
    r'95182637acdb4db1de03fab67ea4a31fe7fc987e';

/// See also [getPackagesByHubId].
@ProviderFor(getPackagesByHubId)
const getPackagesByHubIdProvider = GetPackagesByHubIdFamily();

/// See also [getPackagesByHubId].
class GetPackagesByHubIdFamily extends Family<AsyncValue<List<PackageLine>>> {
  /// See also [getPackagesByHubId].
  const GetPackagesByHubIdFamily();

  /// See also [getPackagesByHubId].
  GetPackagesByHubIdProvider call({
    required int hId,
  }) {
    return GetPackagesByHubIdProvider(
      hId: hId,
    );
  }

  @override
  GetPackagesByHubIdProvider getProviderOverride(
    covariant GetPackagesByHubIdProvider provider,
  ) {
    return call(
      hId: provider.hId,
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
  String? get name => r'getPackagesByHubIdProvider';
}

/// See also [getPackagesByHubId].
class GetPackagesByHubIdProvider extends FutureProvider<List<PackageLine>> {
  /// See also [getPackagesByHubId].
  GetPackagesByHubIdProvider({
    required int hId,
  }) : this._internal(
          (ref) => getPackagesByHubId(
            ref as GetPackagesByHubIdRef,
            hId: hId,
          ),
          from: getPackagesByHubIdProvider,
          name: r'getPackagesByHubIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPackagesByHubIdHash,
          dependencies: GetPackagesByHubIdFamily._dependencies,
          allTransitiveDependencies:
              GetPackagesByHubIdFamily._allTransitiveDependencies,
          hId: hId,
        );

  GetPackagesByHubIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hId,
  }) : super.internal();

  final int hId;

  @override
  Override overrideWith(
    FutureOr<List<PackageLine>> Function(GetPackagesByHubIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPackagesByHubIdProvider._internal(
        (ref) => create(ref as GetPackagesByHubIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hId: hId,
      ),
    );
  }

  @override
  FutureProviderElement<List<PackageLine>> createElement() {
    return _GetPackagesByHubIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPackagesByHubIdProvider && other.hId == hId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPackagesByHubIdRef on FutureProviderRef<List<PackageLine>> {
  /// The parameter `hId` of this provider.
  int get hId;
}

class _GetPackagesByHubIdProviderElement
    extends FutureProviderElement<List<PackageLine>>
    with GetPackagesByHubIdRef {
  _GetPackagesByHubIdProviderElement(super.provider);

  @override
  int get hId => (origin as GetPackagesByHubIdProvider).hId;
}

String _$getPackageItemsHash() => r'e9da9188293ebc3853f4a278c6cd9ca67bcd9f03';

/// See also [getPackageItems].
@ProviderFor(getPackageItems)
const getPackageItemsProvider = GetPackageItemsFamily();

/// See also [getPackageItems].
class GetPackageItemsFamily extends Family<AsyncValue<List<PackageItem>>> {
  /// See also [getPackageItems].
  const GetPackageItemsFamily();

  /// See also [getPackageItems].
  GetPackageItemsProvider call({
    required int pckgId,
    required int hId,
  }) {
    return GetPackageItemsProvider(
      pckgId: pckgId,
      hId: hId,
    );
  }

  @override
  GetPackageItemsProvider getProviderOverride(
    covariant GetPackageItemsProvider provider,
  ) {
    return call(
      pckgId: provider.pckgId,
      hId: provider.hId,
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
  String? get name => r'getPackageItemsProvider';
}

/// See also [getPackageItems].
class GetPackageItemsProvider extends FutureProvider<List<PackageItem>> {
  /// See also [getPackageItems].
  GetPackageItemsProvider({
    required int pckgId,
    required int hId,
  }) : this._internal(
          (ref) => getPackageItems(
            ref as GetPackageItemsRef,
            pckgId: pckgId,
            hId: hId,
          ),
          from: getPackageItemsProvider,
          name: r'getPackageItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPackageItemsHash,
          dependencies: GetPackageItemsFamily._dependencies,
          allTransitiveDependencies:
              GetPackageItemsFamily._allTransitiveDependencies,
          pckgId: pckgId,
          hId: hId,
        );

  GetPackageItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pckgId,
    required this.hId,
  }) : super.internal();

  final int pckgId;
  final int hId;

  @override
  Override overrideWith(
    FutureOr<List<PackageItem>> Function(GetPackageItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPackageItemsProvider._internal(
        (ref) => create(ref as GetPackageItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pckgId: pckgId,
        hId: hId,
      ),
    );
  }

  @override
  FutureProviderElement<List<PackageItem>> createElement() {
    return _GetPackageItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPackageItemsProvider &&
        other.pckgId == pckgId &&
        other.hId == hId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pckgId.hashCode);
    hash = _SystemHash.combine(hash, hId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPackageItemsRef on FutureProviderRef<List<PackageItem>> {
  /// The parameter `pckgId` of this provider.
  int get pckgId;

  /// The parameter `hId` of this provider.
  int get hId;
}

class _GetPackageItemsProviderElement
    extends FutureProviderElement<List<PackageItem>> with GetPackageItemsRef {
  _GetPackageItemsProviderElement(super.provider);

  @override
  int get pckgId => (origin as GetPackageItemsProvider).pckgId;
  @override
  int get hId => (origin as GetPackageItemsProvider).hId;
}

String _$getProductLineByIdHash() =>
    r'7599add337130986af4815e3d095277fd2394375';

/// See also [getProductLineById].
@ProviderFor(getProductLineById)
const getProductLineByIdProvider = GetProductLineByIdFamily();

/// See also [getProductLineById].
class GetProductLineByIdFamily extends Family<AsyncValue<ProductLine>> {
  /// See also [getProductLineById].
  const GetProductLineByIdFamily();

  /// See also [getProductLineById].
  GetProductLineByIdProvider call({
    required int plId,
  }) {
    return GetProductLineByIdProvider(
      plId: plId,
    );
  }

  @override
  GetProductLineByIdProvider getProviderOverride(
    covariant GetProductLineByIdProvider provider,
  ) {
    return call(
      plId: provider.plId,
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
  String? get name => r'getProductLineByIdProvider';
}

/// See also [getProductLineById].
class GetProductLineByIdProvider extends FutureProvider<ProductLine> {
  /// See also [getProductLineById].
  GetProductLineByIdProvider({
    required int plId,
  }) : this._internal(
          (ref) => getProductLineById(
            ref as GetProductLineByIdRef,
            plId: plId,
          ),
          from: getProductLineByIdProvider,
          name: r'getProductLineByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProductLineByIdHash,
          dependencies: GetProductLineByIdFamily._dependencies,
          allTransitiveDependencies:
              GetProductLineByIdFamily._allTransitiveDependencies,
          plId: plId,
        );

  GetProductLineByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.plId,
  }) : super.internal();

  final int plId;

  @override
  Override overrideWith(
    FutureOr<ProductLine> Function(GetProductLineByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProductLineByIdProvider._internal(
        (ref) => create(ref as GetProductLineByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        plId: plId,
      ),
    );
  }

  @override
  FutureProviderElement<ProductLine> createElement() {
    return _GetProductLineByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProductLineByIdProvider && other.plId == plId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, plId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetProductLineByIdRef on FutureProviderRef<ProductLine> {
  /// The parameter `plId` of this provider.
  int get plId;
}

class _GetProductLineByIdProviderElement
    extends FutureProviderElement<ProductLine> with GetProductLineByIdRef {
  _GetProductLineByIdProviderElement(super.provider);

  @override
  int get plId => (origin as GetProductLineByIdProvider).plId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
