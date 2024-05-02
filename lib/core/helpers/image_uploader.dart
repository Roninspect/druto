import 'dart:typed_data';
import 'package:druto/core/helpers/typedefs.dart';
import 'package:fpdart/fpdart.dart';

import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'failure.dart';

class ImageUpload {
  final supabase.SupabaseClient _client;

  ImageUpload({
    required supabase.SupabaseClient client,
  }) : _client = client;

  FutureEither<String?> storeTripImageUrl({
    Uint8List? image,
    required String name,
    required String folderName,
    required String imageExtensions,
  }) async {
    try {
      final String imagepath = '/$name';

      await _client.storage.from(folderName).uploadBinary(imagepath, image!,
          fileOptions: supabase.FileOptions(
              upsert: true, contentType: 'image/$imageExtensions'));

      final String imageUrl =
          _client.storage.from("packages").getPublicUrl(imagepath);
      return right(imageUrl);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
