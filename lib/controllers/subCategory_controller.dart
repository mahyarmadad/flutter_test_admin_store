import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_admin/constant/global_variables.dart';
import 'package:store_app_admin/models/subCategory.dart';
import 'package:store_app_admin/services/manage_http_response.dart';

class SubCategoryController {
  Future<void> uploadSubCategory(
      {required dynamic image,
      required String name,
      required String categoryId,
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

      http.StreamedResponse response = await request.send();
      dynamic responseBody = await response.stream.toBytes();
      dynamic jsonResponse = jsonDecode(String.fromCharCodes(responseBody));

      String imageId = jsonResponse[0]['_id'] ?? '';

      SubCategory subCategory = SubCategory(
          id: "", name: name, imageId: imageId, categoryId: categoryId);

      http.Response categoryResponse = await http.post(
          Uri.parse("$uri/subcategories"),
          body: subCategory.toJson(),
          headers: jsonContentType);

      manageHttpResponse(
          response: categoryResponse,
          context: context,
          onSuccess: () {
            showSnackBar(context, "SubCategory Uploaded", Colors.green);
          });
    } catch (e) {
      showSnackBar(context, "$e", Colors.red);
    }
  }

  Future<List<SubCategory>> loadSubCategories() async {
    try {
      http.Response subCategoriesResponse = await http
          .get(Uri.parse("$uri/subcategories"), headers: jsonContentType);
      List<dynamic> data = jsonDecode(subCategoriesResponse.body);
      List<SubCategory> subCategoriesData =
          data.map((subcategory) => SubCategory.fromJson(subcategory)).toList();
      return subCategoriesData;
    } catch (e) {
      throw Exception("$e");
    }
  }
}
