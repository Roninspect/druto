// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchRepositoryHash() => r'37fa3bb75808a92f1b5a06960315219b5d7c9221';

/// See also [searchRepository].
@ProviderFor(searchRepository)
final searchRepositoryProvider = Provider<SearchRepository>.internal(
  searchRepository,
  name: r'searchRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchRepositoryRef = ProviderRef<SearchRepository>;
String _$searchProductsHash() => r'3ecba990ba201c79502262c5d371d2757284505c';

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

/// See also [searchProducts].
@ProviderFor(searchProducts)
const searchProductsProvider = SearchProductsFamily();

/// See also [searchProducts].
class SearchProductsFamily extends Family<AsyncValue<List<ProductLine>>> {
  /// See also [searchProducts].
  const SearchProductsFamily();

  /// See also [searchProducts].
  SearchProductsProvider call({
    required String query,
    required int hubId,
  }) {
    return SearchProductsProvider(
      query: query,
      hubId: hubId,
    );
  }

  @override
  SearchProductsProvider getProviderOverride(
    covariant SearchProductsProvider provider,
  ) {
    return call(
      query: provider.query,
      hubId: provider.hubId,
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
  String? get name => r'searchProductsProvider';
}

/// See also [searchProducts].
class SearchProductsProvider
    extends AutoDisposeFutureProvider<List<ProductLine>> {
  /// See also [searchProducts].
  SearchProductsProvider({
    required String query,
    required int hubId,
  }) : this._internal(
          (ref) => searchProducts(
            ref as SearchProductsRef,
            query: query,
            hubId: hubId,
          ),
          from: searchProductsProvider,
          name: r'searchProductsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchProductsHash,
          dependencies: SearchProductsFamily._dependencies,
          allTransitiveDependencies:
              SearchProductsFamily._allTransitiveDependencies,
          query: query,
          hubId: hubId,
        );

  SearchProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.hubId,
  }) : super.internal();

  final String query;
  final int hubId;

  @override
  Override overrideWith(
    FutureOr<List<ProductLine>> Function(SearchProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchProductsProvider._internal(
        (ref) => create(ref as SearchProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        hubId: hubId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductLine>> createElement() {
    return _SearchProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchProductsProvider &&
        other.query == query &&
        other.hubId == hubId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, hubId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchProductsRef on AutoDisposeFutureProviderRef<List<ProductLine>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `hubId` of this provider.
  int get hubId;
}

class _SearchProductsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductLine>>
    with SearchProductsRef {
  _SearchProductsProviderElement(super.provider);

  @override
  String get query => (origin as SearchProductsProvider).query;
  @override
  int get hubId => (origin as SearchProductsProvider).hubId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
