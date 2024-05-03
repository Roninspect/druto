import 'package:druto/features/cart/pages/cart_page.dart';
import 'package:druto/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';

class Constants {
  static List<Widget> rootPages = [
    const HomePage(),
    const HomePage2(),
    const CartPage(),
    const HomePage(),
    const HomePage(),
  ];
}
