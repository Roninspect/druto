// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsRepositoryHash() =>
    r'3db53faf3649e5c602172f928b667910eaf86cf2';

/// See also [productsRepository].
@ProviderFor(productsRepository)
final productsRepositoryProvider = Provider<ProductsRepository>.internal(
  productsRepository,
  name: r'productsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductsRepositoryRef = ProviderRef<ProductsRepository>;
String _$getProductsByCategoryHash() =>
    r'4413a9a8844bd3fe7a6f5f782ae8979494ed5265';

/// See also [getProductsByCategory].
@ProviderFor(getProductsByCategory)
final getProductsByCategoryProvider =
    FutureProvider<List<ProductLine>>.internal(
  getProductsByCategory,
  name: r'getProductsByCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getProductsByCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetProductsByCategoryRef = FutureProviderRef<List<ProductLine>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
