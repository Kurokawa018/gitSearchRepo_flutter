import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final githubProvider = ChangeNotifierProvider(
        (ref) => GithubModel()
);

class GithubModel extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> items = [];

  Future<void> search(String query) async {
    var result = await fetchRepositories(query);
    //nullチェック
    items = result!;
    isLoading = false;
    notifyListeners();
  }


  Future<List<dynamic>?> fetchRepositories(String query) async {
    //Loadingの開始
    startLoading();
    //リクエストの開始
    var url = 'https://api.github.com/search/repositories?q=$query';

    var response = await http.get(Uri.parse(url));
    print("===" + response.body + "========");
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['items'];
    } else {
      throw Exception('Failed to load repositories');
    }
    //Loadingの収量
    endLoading();
  }
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }
  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
}

