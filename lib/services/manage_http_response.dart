import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> manageHttpResponse(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) async {
  switch (response.statusCode) {
    case 200:
    case 201:
      onSuccess();
      break;
    case 400:
    case 500:
      final errorMessage =
          jsonDecode(response.body)['message'] ?? 'An unknown error occurred.';
      showSnackBar(context, errorMessage, Colors.red);
      break;
    default:
      showSnackBar(context, 'An unexpected error occurred.', Colors.red);
      break;
  }
}

void showSnackBar(BuildContext context, String title, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: color,
  ));
}
