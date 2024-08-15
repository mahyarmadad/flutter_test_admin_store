import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_admin/constant/global_variables.dart';
import 'package:store_app_admin/services/manage_http_response.dart';
import "package:store_app_admin/models/banner.dart";

class BannerController {
  Future<void> uploadBanner(
      {required dynamic image,
      required String? fileName,
      required context}) async {
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse("$uri/upload"))
            ..headers.addAll({'Content-Type': 'multipart/form-data'});

      request.files.add(http.MultipartFile.fromBytes(
        'images',
        image,
        filename: fileName,
      ));

      http.StreamedResponse response = await request.send();
      dynamic responseBody = await response.stream.toBytes();
      // utf8.decode
      dynamic jsonResponse = jsonDecode(String.fromCharCodes(responseBody));

      String imageId = jsonResponse[0]['_id'] ?? "";

      BannerModel banner = BannerModel(id: "", imageId: imageId);

      http.Response bannerResponse = await http.post(Uri.parse("$uri/banner"),
          body: banner.toJson(), headers: jsonContentType);

      manageHttpResponse(
          response: bannerResponse,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Banner Uploaded", Colors.green);
          });
    } catch (e) {
      showSnackBar(context, "$e", Colors.red);
    }
  }

  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response bannerResponse =
          await http.get(Uri.parse("$uri/banner"), headers: jsonContentType);
      List<dynamic> data = jsonDecode(bannerResponse.body);
      List<BannerModel> bannersData =
          data.map((banner) => BannerModel.fromJson(banner)).toList();
      return bannersData;
    } catch (e) {
      throw Exception("$e");
    }
  }
}
