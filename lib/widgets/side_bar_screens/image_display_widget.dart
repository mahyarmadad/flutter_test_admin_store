import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_admin/constant/global_variables.dart';

class ImageDisplay extends StatelessWidget {
  final String? imageId;

  const ImageDisplay({super.key, required this.imageId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: http.get(Uri.parse('$uri/upload/$imageId')),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.statusCode != 200) {
          return const Text('Failed to load image');
        } else {
          return Image.memory(
            snapshot.data!.bodyBytes,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }
}
