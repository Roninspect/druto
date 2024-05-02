import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _client;
  AuthRepository({required SupabaseClient client}) : _client = client;
}
