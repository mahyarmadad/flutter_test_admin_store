import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:store_app_admin/widgets/side_bar_screens/banner_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/buyers_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/category_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/orders_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/product_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/subCategory_screen.dart';
import 'package:store_app_admin/widgets/side_bar_screens/vendors_screen.dart';

SideBar sidebar(screenSelector) {
  return SideBar(
    header: Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: const Center(
        child: Text(
          "Multi Vendor Store",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.7),
        ),
      ),
    ),
    items: const [
      AdminMenuItem(
          title: "Vendors",
          route: VendorsScreen.id,
          icon: CupertinoIcons.person_3),
      AdminMenuItem(
          title: "Buyers", route: BuyersScreen.id, icon: CupertinoIcons.person),
      AdminMenuItem(
          title: "Orders",
          route: OrdersScreen.id,
          icon: CupertinoIcons.shopping_cart),
      AdminMenuItem(
          title: "Categories", route: CategoryScreen.id, icon: Icons.category),
      AdminMenuItem(
          title: "SubCategories",
          route: SubCategoryScreen.id,
          icon: Icons.account_tree),
      AdminMenuItem(
          title: "Banners", route: BannerScreen.id, icon: Icons.upload),
      AdminMenuItem(
          title: "Products",
          route: ProductScreen.id,
          icon: CupertinoIcons.cube),
    ],
    selectedRoute: VendorsScreen.id,
    onSelected: screenSelector,
  );
}
