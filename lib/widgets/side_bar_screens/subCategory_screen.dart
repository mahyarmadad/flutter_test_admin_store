import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:store_app_admin/controllers/category_controller.dart';
import 'package:store_app_admin/controllers/subCategory_controller.dart';
import 'package:store_app_admin/models/category.dart';
import 'package:store_app_admin/widgets/side_bar_screens/subCategories_widget.dart';

class SubCategoryScreen extends StatefulWidget {
  static const String id = '\subCategory-screen';
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CategoryController categoryController = CategoryController();
  final SubCategoryController subCategoryController = SubCategoryController();

  dynamic image;
  late String subCategoryName;
  var categoryId;

  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

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
                "Sub Categories",
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
                            : const Text("SubCategory Image"),
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
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        validator: (value) => value!.isEmpty
                            ? "Please Enter SubCategory name"
                            : null,
                        onChanged: (value) => subCategoryName = value,
                        decoration: const InputDecoration(
                            labelText: "Enter SubCategory Name"),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FutureBuilder(
                          future: futureCategories,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                            return DropdownButton(
                                value: categoryId,
                                items: snapshot.data!
                                    .map((category) => DropdownMenuItem(
                                          value: category.id,
                                          child: Text(category.name),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    categoryId = value!;
                                  });
                                });
                          })),
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
                        await subCategoryController.uploadSubCategory(
                            image: image,
                            name: subCategoryName,
                            categoryId: categoryId,
                            context: context);
                        setState(() {
                          formKey.currentState!.reset();
                          image = null;
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
          const SubCategoriesWidget()
        ],
      ),
    );
  }
}
