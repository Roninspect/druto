// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$configRepositoryHash() => r'c5c3b556859c9823d0439090307f86fac6ea4a77';

/// See also [configRepository].
@ProviderFor(configRepository)
final configRepositoryProvider = Provider<ConfigRepository>.internal(
  configRepository,
  name: r'configRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$configRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConfigRepositoryRef = ProviderRef<ConfigRepository>;
String _$getConfigsHash() => r'460ab4adf03606f543fa521a4dd11307d464c2ef';

/// See also [getConfigs].
@ProviderFor(getConfigs)
final getConfigsProvider = FutureProvider<Configs>.internal(
  getConfigs,
  name: r'getConfigsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getConfigsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetConfigsRef = FutureProviderRef<Configs>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
