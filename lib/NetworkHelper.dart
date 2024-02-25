import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  String url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String body = response.body;
      return jsonDecode(body);
    } else {
      print("STATUS CODE :: ${response.statusCode}");
    }
  }
}
