import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/search/providers/search_query_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      cursorColor: primaryColor,
      onChanged: (value) {
        ref.read(searchQueryProvider.notifier).setQuery(value);
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          filled: true,
          fillColor: Colors.grey[200],
          border: InputBorder.none,
          suffixIcon: const Icon(Icons.search),
          hintText: "Search Products"),
    );
  }
}
