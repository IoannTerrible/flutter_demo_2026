import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class NetworkHelper {
  static const _url = 'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/eur.json';

  Future<void> init() async {}

  Future<String> get(int id) async {
    try {
      final res = await http.get(Uri.parse('$_url'));
      debugPrint('Status: ${res.statusCode}');
      debugPrint(res.body);
      if(res.statusCode != 200) return "Sorry Error";
      return json.decode(res.body)['eur']['eur'];
    } on SocketException {
      return 'Sorry not available';
    } catch (error) {
      return 'Error: $error';
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
    } on SocketException {
      return 'Sorry not available';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
