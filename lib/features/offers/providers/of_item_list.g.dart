// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'of_item_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$offerItemsListHash() => r'b60407576d680fa423d6b2f016e8fe70338437f6';

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

abstract class _$OfferItemsList
    extends BuildlessAutoDisposeAsyncNotifier<List<OfferItem>> {
  late final int ofl_id;
  late final String path;

  FutureOr<List<OfferItem>> build({
    required int ofl_id,
    required String path,
  });
}

/// See also [OfferItemsList].
@ProviderFor(OfferItemsList)
const offerItemsListProvider = OfferItemsListFamily();

/// See also [OfferItemsList].
class OfferItemsListFamily extends Family<AsyncValue<List<OfferItem>>> {
  /// See also [OfferItemsList].
  const OfferItemsListFamily();

  /// See also [OfferItemsList].
  OfferItemsListProvider call({
    required int ofl_id,
    required String path,
  }) {
    return OfferItemsListProvider(
      ofl_id: ofl_id,
      path: path,
    );
  }

  @override
  OfferItemsListProvider getProviderOverride(
    covariant OfferItemsListProvider provider,
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
  String? get name => r'offerItemsListProvider';
}

/// See also [OfferItemsList].
class OfferItemsListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    OfferItemsList, List<OfferItem>> {
  /// See also [OfferItemsList].
  OfferItemsListProvider({
    required int ofl_id,
    required String path,
  }) : this._internal(
          () => OfferItemsList()
            ..ofl_id = ofl_id
            ..path = path,
          from: offerItemsListProvider,
          name: r'offerItemsListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$offerItemsListHash,
          dependencies: OfferItemsListFamily._dependencies,
          allTransitiveDependencies:
              OfferItemsListFamily._allTransitiveDependencies,
          ofl_id: ofl_id,
          path: path,
        );

  OfferItemsListProvider._internal(
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
  FutureOr<List<OfferItem>> runNotifierBuild(
    covariant OfferItemsList notifier,
  ) {
    return notifier.build(
      ofl_id: ofl_id,
      path: path,
    );
  }

  @override
  Override overrideWith(OfferItemsList Function() create) {
    return ProviderOverride(
      origin: this,
      override: OfferItemsListProvider._internal(
        () => create()
          ..ofl_id = ofl_id
          ..path = path,
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
  AutoDisposeAsyncNotifierProviderElement<OfferItemsList, List<OfferItem>>
      createElement() {
    return _OfferItemsListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OfferItemsListProvider &&
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

mixin OfferItemsListRef
    on AutoDisposeAsyncNotifierProviderRef<List<OfferItem>> {
  /// The parameter `ofl_id` of this provider.
  int get ofl_id;

  /// The parameter `path` of this provider.
  String get path;
}

class _OfferItemsListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OfferItemsList,
        List<OfferItem>> with OfferItemsListRef {
  _OfferItemsListProviderElement(super.provider);

  @override
  int get ofl_id => (origin as OfferItemsListProvider).ofl_id;
  @override
  String get path => (origin as OfferItemsListProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
