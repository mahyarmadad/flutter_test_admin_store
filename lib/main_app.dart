import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:store_app_admin/widgets/side_bar_screens/banner_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/buyers_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/category_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/orders_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/product_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/subCategory_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/vendors_screen.dart';
import 'package:store_app_admin/widgets/sidebar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget selectedScreen = const VendorsScreen();

  screenSelector(item) {
    switch (item.route) {
      case BuyersScreen.id:
        setState(() {
          selectedScreen = const BuyersScreen();
        });
        break;
      case VendorsScreen.id:
        setState(() {
          selectedScreen = const VendorsScreen();
        });
        break;
      case OrdersScreen.id:
        setState(() {
          selectedScreen = const OrdersScreen();
        });
        break;
      case CategoryScreen.id:
        setState(() {
          selectedScreen = const CategoryScreen();
        });
        break;
      case SubCategoryScreen.id:
        setState(() {
          selectedScreen = const SubCategoryScreen();
        });
        break;
      case BannerScreen.id:
        setState(() {
          selectedScreen = const BannerScreen();
        });
        break;
      case ProductScreen.id:
        setState(() {
          selectedScreen = const ProductScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Admin Panel"),
      ),
      body: selectedScreen,
      sideBar: sidebar(screenSelector),
    );
  }
}
