import 'package:flutter/material.dart';
import 'package:store_app_admin/controllers/subCategory_controller.dart';
import 'package:store_app_admin/models/subCategory.dart';
import 'package:store_app_admin/widgets/side_bar_screens/Image_display_widget.dart';

class SubCategoriesWidget extends StatefulWidget {
  const SubCategoriesWidget({super.key});

  @override
  State<SubCategoriesWidget> createState() => _SubCategoriesWidgetState();
}

class _SubCategoriesWidgetState extends State<SubCategoriesWidget> {
  late Future<List<SubCategory>> futureSubCategories;

  @override
  void initState() {
    super.initState();
    futureSubCategories = SubCategoryController().loadSubCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureSubCategories,
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
          final subCategories = snapshot.data;
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: subCategories?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final subCategory = subCategories?[index];
                final imageId = subCategory?.imageId;
                final categoryId = subCategory?.categoryId ?? '';
                final name = subCategory?.name ?? "";
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ImageDisplay(imageId: imageId),
                      Text(name),
                      Text(categoryId),
                    ],
                  ),
                );
              });
        });
  }
}
