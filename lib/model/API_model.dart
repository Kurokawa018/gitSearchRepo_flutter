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
  bool  isEmpty = false;
  bool  isSearched = false;
  bool  isError = false;

  Future<void> search(String query) async {
    var result = await fetchRepositories(query);
    //nullチェック
    items = result!;
    if (items.length == 0) {
      //リクエストが返ってきたが、レスポンスが空の時
      isEmpty = true;
    } else {
      //リクエストが返ってきてかつ、レスポンスが空じゃないとき
      isSearched = true;
    }
    endLoading();
    notifyListeners();
  }


  Future<List<dynamic>> fetchRepositories(String query) async {
    //Loadingの開始
    startLoading();
    //リクエストの開始
    var url = 'https://api.github.com/search/repositories?q=$query';

    var response = await http.get(Uri.parse(url));
    print("===" + response.body + "========");
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse['items'];
    } else {//StatusCodeが200以外の時
      //ErrorResultsの表示用フラグ
      isError = true;
      //Loadingの終了
      isLoading = false;
      notifyListeners();
      // print(response.statusCode);
      throw Exception('Failed to load repositories');
    }

  }
  void startLoading() {
    isLoading = true;
    isEmpty = false;
    notifyListeners();
  }
  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void onChanged() {
    //TextFieldの値が変更されたとき
    isSearched = false;
    isLoading = false;
    isError = false;
    notifyListeners();
  }

}

