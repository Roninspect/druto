import 'package:druto/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserOrderPage extends ConsumerWidget {
  const UserOrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Orders"),
        ),
        body: const DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                indicatorColor: primaryColor,
                labelColor: Colors.green,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Processing"),
                  Tab(text: "Cancelled"),
                  Tab(text: "All"),
                ],
              ),
              Expanded(
                  child: TabBarView(children: [
                Center(
                  child: Text("Processing"),
                ),
                Center(
                  child: Text("Cancelled"),
                ),
                Center(
                  child: Text("All"),
                ),
              ]))
            ],
          ),
        ));
  }
}
