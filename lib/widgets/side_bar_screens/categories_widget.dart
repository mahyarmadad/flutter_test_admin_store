import 'package:flutter/material.dart';
import 'package:store_app_admin/controllers/category_controller.dart';
import 'package:store_app_admin/models/category.dart';
import 'package:store_app_admin/widgets/side_bar_screens/Image_display_widget.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Categories"),
            );
          }
          final categories = snapshot.data;
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: categories?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final category = categories?[index];
                final imageId = category?.imageId;
                final bannerId = category?.bannerId;
                final name = category?.name ?? "";
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ImageDisplay(imageId: imageId),
                      Text(name),
                      ImageDisplay(imageId: bannerId),
                    ],
                  ),
                );
              });
        });
  }
}
