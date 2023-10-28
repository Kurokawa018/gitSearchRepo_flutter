import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class GithubClient {
  Future<List<dynamic>?> get(String query) async {
    var url = 'https://api.github.com/search/repositories?q=$query';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['items'];
    }
  }
}