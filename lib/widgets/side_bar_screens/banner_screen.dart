import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:store_app_admin/controllers/banner_controller.dart';
import 'package:store_app_admin/widgets/side_bar_screens/banner_widget.dart';

class BannerScreen extends StatefulWidget {
  static const String id = '\banner-screen';

  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final BannerController bannerController = BannerController();
  dynamic image;
  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Banners",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
        Padding(
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
                        : const Text("Banner Image"),
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
              TextButton(onPressed: () {}, child: const Text("Cancel")),
              ElevatedButton(
                onPressed: () {
                  if (image != null) {
                    bannerController.uploadBanner(
                        image: image, fileName: fileName, context: context);
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
        const Divider(
          color: Colors.grey,
        ),
        const BannerWidget(),
      ],
    );
  }
}
