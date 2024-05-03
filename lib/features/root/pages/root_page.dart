import 'package:druto/core/constants/root_pages.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:badges/badges.dart' as badges;

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});

  @override
  ConsumerState<RootPage> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final length = ref.watch(getlocalCartItemsProvider).valueOrNull;

    return SafeArea(
      child: Scaffold(
        body: TabBarView(
            controller: tabController, children: Constants.rootPages),
        bottomNavigationBar: TabBar(
            labelPadding: const EdgeInsets.symmetric(vertical: 6),
            labelColor: primaryColor,
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: primaryColor, width: 3.0),
              insets: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 55.0),
            ),
            controller: tabController,
            tabs: [
              const Tab(
                child: Icon(
                  FontAwesome.home,
                  size: 27,
                ),
              ),
              const Tab(
                child: Icon(Entypo.text_document),
              ),
              Tab(
                  child: badges.Badge(
                badgeContent: Text(
                  length == null ? "120" : length.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                position: badges.BadgePosition.custom(start: 42, top: 0),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                ),
              )),
              const Tab(
                child: Icon(
                  MaterialCommunityIcons.heart,
                  size: 27,
                ),
              ),
              const Tab(
                child: Icon(
                  Ionicons.person,
                  size: 22,
                ),
              ),
            ]),
      ),
    );
  }
}

// BottomNavigationBar(
//           currentIndex: navIndex,
//           unselectedItemColor: Colors.black,
//           selectedItemColor: Colors.green,
//           onTap: (value) =>
//               ref.read(navIndexProvider.notifier).changeIndex(index: value),
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           ]),
