import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:store_app_admin/controllers/category_controller.dart';
import 'package:store_app_admin/widgets/side_bar_screens/categories_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = '\category-screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CategoryController categoryController = CategoryController();
  dynamic image;
  dynamic bannerImage;

  late String categoryName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        image = result.files.first.bytes;
      });
    }
  }

  pickBannerImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        bannerImage = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "Categories",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: image != null
                            ? Image.memory(image)
                            : const Text("Category Image"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            pickImage();
                          },
                          child: const Text("Select Image")),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: bannerImage != null
                                ? Image.memory(bannerImage)
                                : const Text("Banner Image"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                pickBannerImage();
                              },
                              child: const Text("Select Image")),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        validator: (value) => value!.isEmpty
                            ? "Please Enter Category name"
                            : null,
                        onChanged: (value) => categoryName = value,
                        decoration: const InputDecoration(
                            labelText: "Enter Category Name"),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          formKey.currentState!.reset();
                        });
                      },
                      child: const Text("Cancel")),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await categoryController.uploadCategory(
                            image: image,
                            banner: bannerImage,
                            name: categoryName,
                            context: context);

                        setState(() {
                          formKey.currentState!.reset();
                          image = null;
                          bannerImage = null;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          const CategoriesWidget()
        ],
      ),
    );
  }
}
