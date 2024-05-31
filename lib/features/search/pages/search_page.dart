import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/search/providers/search_query_provider.dart';
import 'package:druto/features/search/widgets/search_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String query = ref.watch(searchQueryProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                ref.invalidate(searchQueryProvider);
                context.pop();
              },
              icon: const Icon(Icons.arrow_back)),
          toolbarHeight: context.height * 0.1,
          backgroundColor: Colors.green[200],
          title: TextField(
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
          ),
        ),
        body: query.length > 2
            ? const SearchResultListView()
            : const SizedBox.shrink());
  }
}
