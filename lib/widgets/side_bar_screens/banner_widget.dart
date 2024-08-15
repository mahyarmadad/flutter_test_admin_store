import 'package:flutter/material.dart';
import 'package:store_app_admin/controllers/banner_controller.dart';
import 'package:store_app_admin/models/banner.dart';
import 'package:store_app_admin/widgets/side_bar_screens/Image_display_widget.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureBanners,
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
              child: Text("No Banners"),
            );
          }
          final banners = snapshot.data;
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: banners?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final banner = banners?[index];
                final imageId = banner?.imageId;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageDisplay(imageId: imageId),
                );
              });
        });
  }
}
