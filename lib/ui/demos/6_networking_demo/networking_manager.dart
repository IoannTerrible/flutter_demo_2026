import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class NetworkHelper {
  static const _url = 'https://dummyjson.com';

  Future<void> init() async {}

  Future<String> get(int id) async {
    try {
      final res = await http.get(Uri.parse('$_url/posts/$id'));
      debugPrint('Status: ${res.statusCode}');
      debugPrint(res.body);
      return res.body;
    } catch (e) {
      debugPrint('GET failed: $e');
      return 'Error: $e';
    }
  }

  Future<String> post(Map<String, dynamic> content) async {
    try {
      final res = await http.post(
        Uri.parse('$_url/posts/add'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(content),
      );
      debugPrint('Status: ${res.statusCode}');
      debugPrint(res.body);
      return res.body;
    } catch (e) {
      debugPrint('POST faild: $e');
      return 'Error: $e';
    }
  }
}
