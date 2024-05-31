import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

class SearchQueryNotifier extends Notifier<String> {
  @override
  build() {
    return "";
  }

  void setQuery(String query) {
    state = query;
  }
}
