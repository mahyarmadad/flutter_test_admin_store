import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_admin/constant/global_variables.dart';
import 'package:store_app_admin/models/category.dart';
import 'package:store_app_admin/services/manage_http_response.dart';

class CategoryController {
  Future<void> uploadCategory(
      {required dynamic image,
      required dynamic banner,
      required String name,
      required context}) async {
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse("$uri/upload"))
            ..headers.addAll({'Content-Type': 'multipart/form-data'});

      request.files.add(http.MultipartFile.fromBytes(
        'images',
        image,
        filename: name,
      ));
      if (banner != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'images',
          banner,
          filename:
              "${name}_banner", // Assuming banner format is JPEG, adjust accordingly
        ));
      }

      http.StreamedResponse response = await request.send();
      dynamic responseBody = await response.stream.toBytes();
      dynamic jsonResponse = jsonDecode(String.fromCharCodes(responseBody));

      String imageId = jsonResponse[0]['_id'] ?? '';
      String bannerId = jsonResponse[1]['_id'] ?? '';

      Category category =
          Category(id: "", name: name, imageId: imageId, bannerId: bannerId);

      http.Response categoryResponse = await http.post(
          Uri.parse("$uri/categories"),
          body: category.toJson(),
          headers: jsonContentType);

      manageHttpResponse(
          response: categoryResponse,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Category Uploaded", Colors.green);
          });
    } catch (e) {
      showSnackBar(context, "$e", Colors.red);
    }
  }

  Future<List<Category>> loadCategories() async {
    try {
      http.Response categoriesResponse = await http
          .get(Uri.parse("$uri/categories"), headers: jsonContentType);
      List<dynamic> data = jsonDecode(categoriesResponse.body);
      List<Category> categoriesData =
          data.map((category) => Category.fromJson(category)).toList();
      return categoriesData;
    } catch (e) {
      throw Exception("$e");
    }
  }
}
