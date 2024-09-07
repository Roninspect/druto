// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$offerRepositoryHash() => r'4cb07468b1312f5263da5b9b0b546a05e236d23e';

/// See also [offerRepository].
@ProviderFor(offerRepository)
final offerRepositoryProvider = Provider<OfferRepository>.internal(
  offerRepository,
  name: r'offerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$offerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OfferRepositoryRef = ProviderRef<OfferRepository>;
String _$getOffersHash() => r'1f574b2732f041f770ae1dc51ed3f85cd72c6f08';

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

/// See also [getOffers].
@ProviderFor(getOffers)
const getOffersProvider = GetOffersFamily();

/// See also [getOffers].
class GetOffersFamily extends Family<AsyncValue<List<OfferLine>>> {
  /// See also [getOffers].
  const GetOffersFamily();

  /// See also [getOffers].
  GetOffersProvider call({
    required int h_id,
  }) {
    return GetOffersProvider(
      h_id: h_id,
    );
  }

  @override
  GetOffersProvider getProviderOverride(
    covariant GetOffersProvider provider,
  ) {
    return call(
      h_id: provider.h_id,
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
  String? get name => r'getOffersProvider';
}

/// See also [getOffers].
class GetOffersProvider extends FutureProvider<List<OfferLine>> {
  /// See also [getOffers].
  GetOffersProvider({
    required int h_id,
  }) : this._internal(
          (ref) => getOffers(
            ref as GetOffersRef,
            h_id: h_id,
          ),
          from: getOffersProvider,
          name: r'getOffersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getOffersHash,
          dependencies: GetOffersFamily._dependencies,
          allTransitiveDependencies: GetOffersFamily._allTransitiveDependencies,
          h_id: h_id,
        );

  GetOffersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.h_id,
  }) : super.internal();

  final int h_id;

  @override
  Override overrideWith(
    FutureOr<List<OfferLine>> Function(GetOffersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOffersProvider._internal(
        (ref) => create(ref as GetOffersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        h_id: h_id,
      ),
    );
  }

  @override
  FutureProviderElement<List<OfferLine>> createElement() {
    return _GetOffersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOffersProvider && other.h_id == h_id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, h_id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetOffersRef on FutureProviderRef<List<OfferLine>> {
  /// The parameter `h_id` of this provider.
  int get h_id;
}

class _GetOffersProviderElement extends FutureProviderElement<List<OfferLine>>
    with GetOffersRef {
  _GetOffersProviderElement(super.provider);

  @override
  int get h_id => (origin as GetOffersProvider).h_id;
}

String _$getOfferItemsHash() => r'9c6765cc3558d86a7974b915ff1076685c0fb010';

/// See also [getOfferItems].
@ProviderFor(getOfferItems)
const getOfferItemsProvider = GetOfferItemsFamily();

/// See also [getOfferItems].
class GetOfferItemsFamily extends Family<AsyncValue<List<OfferItem>>> {
  /// See also [getOfferItems].
  const GetOfferItemsFamily();

  /// See also [getOfferItems].
  GetOfferItemsProvider call({
    required int ofl_id,
    required String path,
  }) {
    return GetOfferItemsProvider(
      ofl_id: ofl_id,
      path: path,
    );
  }

  @override
  GetOfferItemsProvider getProviderOverride(
    covariant GetOfferItemsProvider provider,
  ) {
    return call(
      ofl_id: provider.ofl_id,
      path: provider.path,
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
  String? get name => r'getOfferItemsProvider';
}

/// See also [getOfferItems].
class GetOfferItemsProvider extends FutureProvider<List<OfferItem>> {
  /// See also [getOfferItems].
  GetOfferItemsProvider({
    required int ofl_id,
    required String path,
  }) : this._internal(
          (ref) => getOfferItems(
            ref as GetOfferItemsRef,
            ofl_id: ofl_id,
            path: path,
          ),
          from: getOfferItemsProvider,
          name: r'getOfferItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getOfferItemsHash,
          dependencies: GetOfferItemsFamily._dependencies,
          allTransitiveDependencies:
              GetOfferItemsFamily._allTransitiveDependencies,
          ofl_id: ofl_id,
          path: path,
        );

  GetOfferItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ofl_id,
    required this.path,
  }) : super.internal();

  final int ofl_id;
  final String path;

  @override
  Override overrideWith(
    FutureOr<List<OfferItem>> Function(GetOfferItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOfferItemsProvider._internal(
        (ref) => create(ref as GetOfferItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ofl_id: ofl_id,
        path: path,
      ),
    );
  }

  @override
  FutureProviderElement<List<OfferItem>> createElement() {
    return _GetOfferItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOfferItemsProvider &&
        other.ofl_id == ofl_id &&
        other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ofl_id.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetOfferItemsRef on FutureProviderRef<List<OfferItem>> {
  /// The parameter `ofl_id` of this provider.
  int get ofl_id;

  /// The parameter `path` of this provider.
  String get path;
}

class _GetOfferItemsProviderElement
    extends FutureProviderElement<List<OfferItem>> with GetOfferItemsRef {
  _GetOfferItemsProviderElement(super.provider);

  @override
  int get ofl_id => (origin as GetOfferItemsProvider).ofl_id;
  @override
  String get path => (origin as GetOfferItemsProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
