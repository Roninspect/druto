import 'package:druto/models/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'config_provider.g.dart';

@Riverpod(keepAlive: true)
ConfigRepository configRepository(ref) {
  return ConfigRepository(client: Supabase.instance.client);
}

@Riverpod(keepAlive: true)
Future<Configs> getConfigs(ref) async {
  return ref.watch(configRepositoryProvider).getConfigs();
}

class ConfigRepository {
  final SupabaseClient client;
  ConfigRepository({
    required this.client,
  });

  Future<Configs> getConfigs() async {
    try {
      final res = await client.from("configs").select('min_delivery').single();

      final Configs configs = Configs.fromMap(res);

      return configs;
    } catch (e) {
      rethrow;
    }
  }
}
