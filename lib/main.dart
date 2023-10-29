//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

//models
import 'model/API_model.dart';

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
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter a keyword',
                  ),
                  controller: _controller,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    //gitHubモデルのsearch起動
                    await githubModel.search(_controller.text);
                    _items = githubModel.items;
                  },
                    child: Text('Search'),
                    ),
                SizedBox(height: 20),
                _items.length == 0 ? Text(
                    "No results found.", textAlign: TextAlign.left,
                    style: TextStyle(fontSize: titleFontSize))
                        : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Search Results', textAlign: TextAlign.left,
                    style: TextStyle(fontSize: titleFontSize),),
                    ]
                    ),
                SizedBox(height: 20),
                githubModel.isLoading ?
                  Center(
                    child: const Text("Loading now"),
                  ):
                  SizedBox(height: 20),
                Expanded(
                  child :
                      ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Hero(
                                  tag: _items[index]['full_name'],
                                  child: ListTile(
                                    title: Text(_items[index]['full_name']),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            DetailPage(item: _items[index])),
                                      );
                                    },
                                  ),
                                ),
                                Divider(thickness: 1),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
