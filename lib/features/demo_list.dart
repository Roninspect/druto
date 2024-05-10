import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemoListView extends ConsumerWidget {
  const DemoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const pageSize = 20;
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final page = index ~/ pageSize + 1;
          final indexInPage = index % pageSize;

          print('index: $index, page: $page, indexInPage: $indexInPage');
          return SizedBox(height: 200, child: Text(index.toString()));
        },
      ),
    );
  }
}
