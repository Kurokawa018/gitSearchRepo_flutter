//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

//models
import 'model/API_model.dart';

//components
import 'components/search_results.dart';


//views
import 'views/details_page.dart';

//constants
import '../constants/doubles.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ゆめみ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {

  final _controller = TextEditingController();
  List<dynamic> _items = [];
  bool  isLoading = false;
  String query = "";
  // void _search() async {
  //   var client = new GithubModel();
  //   var result = await client.fetchRepositories(_controller.text);
  //   print("=====getting API results==========");
  //   //nullチェック
  //   _items = result!;
  //   print(_items
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GithubModel githubModel = ref.watch(githubProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text("ゆめみ Flutter", style: TextStyle(fontSize: titleFontSize),),
      ),
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter a keyword',
                  ),
                  controller: _controller,
                  onChanged: (text) {
                    githubModel.onChanged();
                    query = text;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    //gitHubモデルのsearch起動
                    await githubModel.search(query);
                    _items = githubModel.items;
                  },
                    child: Text('Search'),
                    ),
                SizedBox(height: 20),
                Expanded(child: SearchResultBuilder(githubModel: githubModel, items: _items))
                  ],
                ),
              )

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
